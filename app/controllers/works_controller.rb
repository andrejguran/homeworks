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
  end

  def show
    @work = Work.find(params[:id])
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

    render :text => @work.generate
  end

  # =Displays the content of files
  # == Three types of highlighting
  # - java: java language highlights
  # - xquery: php language highlights
  # - xslt: xml language highlights
  def homework
    @work = Work.find(params[:id])

    render text: @work.render
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

    if @work.save
      unless @work.compilable?
        @work.destroy
        return redirect_to :back, alert: 'Unable to compile'
      end

      @work.compile

      @work.save

      return redirect_to @work, notice: 'Work was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @work = Work.find(params[:id])

    if @work.update_attributes(params[:work])
      redirect_to work_url(@work), notice: 'Work was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @work = Work.find(params[:id])
    @work.destroy

    redirect_to @work.task
  end

end
