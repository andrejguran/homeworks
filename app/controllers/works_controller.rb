class WorksController < ApplicationController
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  before_filter :authenticate_user!
  before_filter :check_my_work, :only => [:show, :generated, :homework]
  before_filter :check_admin, :only => [:index, :edit, :update, :destroy]

  private

  # Returns boolean wheather the current user is admin
  def is_admin?
    current_user && current_user.admin
  end

  # Checks if the current user is admin, if not redirection is placed
  def check_admin
    unless is_admin?
      flash[:notice] = "You must be admin in to access this section"
      redirect_to work_url(params[:id])
    end
  end

  # Checks if concrete work belongs to current user, if user is not admin
  def check_my_work
    if (!is_admin? && (Work.find(params[:id]).user != current_user))
      flash[:notice] = "Not your work"
      redirect_to tasks_url()
    end
  end

  public

  def index
    @works = Work.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @works }
      format.xml { render xml: @works }
    end
  end

  def show
    @work = Work.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @work }
      format.xml { render xml: @work }
    end
  end

  # = Generates the output
  # == Generation of
  # * XSLT: xsl file and xml file are combined to generate html page
  # * Xquery: xq file contains path to xml file and xml file is generated
  # * Java: output of junit test is displayed
  # == Three types of highlighting
  # * XSLT transformation: html page is rendered
  # * XQuery transformation: xml format highlighting
  # * Java unit test output: output is highlighted as java lang
  def generated
    @work = Work.find(params[:id])
    if params[:language] == "xslt"
      xsl_file = File.join(upload_dir, "homework/src", @work.user.uco.to_s, @work.id.to_s, @work.task.package.tr(".", "/"), @work.homework_file_name)
      xml_file = File.join(upload_dir, "homework/src/tests", @work.task.id.to_s, @work.task.package.tr(".", "/"), @work.task.task_file_file_name)
      doc = Nokogiri::XML(File.read(xml_file))
      xslt = Nokogiri::XSLT(File.read(xsl_file))

      transform = xslt.transform(doc)

      render :text => transform
    elsif params[:language] == "xquery"
      xq_file = File.join(upload_dir, "homework/src", @work.user.uco.to_s, @work.id.to_s, @work.task.package.tr(".", "/"), @work.homework_file_name)
      command = "java -cp " + Rails.root.to_s + "/lib/assets/saxon9he.jar net.sf.saxon.Query " + xq_file
      response = `#{command}`

      require 'rexml/document'
      doc = REXML::Document.new(response)
      f = REXML::Formatters::Pretty.new
      pretty_xml = String.new
      f.write(doc, pretty_xml)

      render :text => CodeRay.scan(pretty_xml, :xml).div
    elsif params[:language] == "java"
      require "fileutils"
      classes_path = File.join(upload_dir, "homework/classes", @work.user.uco.to_s, @work.id.to_s)

      include_class_path = "-cp " + classes_path + separator + Rails.root.to_s + "/lib/assets/junit.jar" + separator + Rails.root.to_s + "/lib/assets/hamcrest-core.jar "
      command_run_test = "java " + include_class_path  + "org.junit.runner.JUnitCore " + @work.task.package + "." + File.basename(@work.task.task_file_file_name, ".*")

      ##return render text: command_run_test

      response_run_test = `#{command_run_test}`

      render :text => CodeRay.scan(response_run_test, :java).div
    end
  end

  # =Displays the content of files
  # == Three types of highlighting
  # - java: java language highlights
  # - xquery: php language highlights
  # - xslt: xml language highlights
  def homework
    @work = Work.find(params[:id])
    file_name = File.join(upload_dir, "homework/src", @work.user.uco.to_s, @work.id.to_s, @work.task.package.tr(".", "/"), @work.homework_file_name)
    file = File.open(file_name, "r")
    data = file.read
    file.close

    if @work.task.language == "java"
      render text:  CodeRay.scan(data, :java).div
    elsif @work.task.language == "xquery"
      render text:  CodeRay.scan(data, :php).div
    else
      render text:  CodeRay.scan(data, :xml).div
    end
  end

  def edit
    @work = Work.find(params[:id])
  end

  # =Creates work and bind it to task
  # ==Types of works
  # - Java: uploaded java file is copied to classes directory. File is then compiled with the test. If the response contains failures, status is marked as fail, othervise as success.
  # - XSLT and Xquery: files are moved to user's directories and waits to be generated.
  def create

    @work = Work.new(params[:work])
    @work.task_id = params[:task_id]
    @work.user_id = current_user.id



    respond_to do |format|
      if @work.save

        if @work.task.language == "java"
          require "fileutils"

          new_file_dir = File.join(upload_dir, "homework/src", current_user.uco.to_s, @work.id.to_s, @work.task.package.tr(".", "/"))
          new_file_path = File.join(new_file_dir, @work.homework_file_name)
          FileUtils.mkdir_p(File.dirname(new_file_path))
          FileUtils.cp @work.homework.path, new_file_path

          command = "javac " + new_file_path
          response = system(command)

          unless response
            @work.destroy
            return redirect_to :back, alert: 'Unable to compile' + command.to_s + " --- " + response.to_s
          end

          classes_path = File.join(upload_dir, "homework/classes", current_user.uco.to_s, @work.id.to_s)
          FileUtils.mkdir_p(classes_path)

          junit_path = File.join(Rails.root, "lib/assets/junit.jar")
          work_file_path = new_file_path
          test_file_path = File.join(upload_dir, "homework/src/tests", @work.task.id.to_s, @work.task.package.tr(".", "/"), File.basename(@work.task.task_file_file_name, ".*")) + ".java"
          command_compile_src_and_test = "javac -cp " + junit_path + " -d " + classes_path +" " + work_file_path + " " + test_file_path
          response_compile_src_and_test = `#{command_compile_src_and_test}`

          test_files = File.join(upload_dir, "homework/src/tests", @work.task.id.to_s, @work.task.package.tr(".", "/")) + "/*"
          #return render text: command_compile_src_and_test
          FileUtils.cp_r Dir.glob(test_files), File.join(classes_path, @work.task.package.tr(".", "/"))

          include_class_path = "-cp " + classes_path + separator + Rails.root.to_s + "/lib/assets/junit.jar" + separator + Rails.root.to_s + "/lib/assets/hamcrest-core.jar "
          command_run_test = "java " + include_class_path  + "org.junit.runner.JUnitCore " + @work.task.package + "." + @work.task.task_file_file_name[0..-6]
          response_run_test = `#{command_run_test}`

          if response_run_test.include? "FAILURES!" or response_run_test.include? "Could not find class"
            @work.status = "fail"
          elsif response_run_test.include? "OK"
            @work.status = "success"
          end

          @work.save
        elsif @work.task.language == "xslt"
          begin
            Nokogiri::XSLT(File.read(@work.homework.path))
          rescue
            @work.destroy
            return redirect_to :back, alert: 'Unable to compile'
          end

          new_file_path = File.join(upload_dir, "homework/src", current_user.uco.to_s, @work.id.to_s, @work.task.package.tr(".", "/"), @work.homework_file_name)
          FileUtils.mkdir_p(File.dirname(new_file_path))
          FileUtils.cp @work.homework.path, new_file_path
        elsif @work.task.language == "xquery"
          new_file_path = File.join(upload_dir, "homework/src", current_user.uco.to_s, @work.id.to_s, @work.task.package.tr(".", "/"), @work.homework_file_name)
          FileUtils.mkdir_p(File.dirname(new_file_path))
          FileUtils.cp @work.homework.path, new_file_path

          command = "java -cp " + Rails.root.to_s + "/lib/assets/saxon9he.jar net.sf.saxon.Query " + new_file_path
          response = system(command)

          unless response
            @work.destroy
            return redirect_to :back, alert: 'Unable to compile'
          end
        end

        format.html { redirect_to @work, notice: 'Work was successfully created.' }
        format.json { render json: @work, status: :created, location: @work }
        format.xml { render xml: @work, status: :created, location: @work }
      else
        format.html { render action: "new" }
        format.xml { render xml: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @work = Work.find(params[:id])

    respond_to do |format|
      if @work.update_attributes(params[:work])
        format.html { redirect_to work_url(@work), notice: 'Work was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @work.errors, status: :unprocessable_entity }
        format.xml { render xml: @work.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    respond_to do |format|
      format.html { redirect_to works_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end

  def compile? file
    command = "javac " + file
    response = `#{command}`
    !response.include? "error"
  end

end
