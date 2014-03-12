class TasksController < ApplicationController

  include ApplicationHelper

  before_filter :is_admin?, :only => [:new, :create, :edit, :update, :destroy]

  private

  # Checks if the current user is admin
  def is_admin?
    unless (current_user && current_user.admin)
      flash[:notice] = "You must be admin in to access this section"
      redirect_to tasks_url
    end
  end

  public

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
      format.xml { render xml: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
      format.xml { render xml: @tasks }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  # Creates new task, move file to test directory under package.
  def create
    @task = Task.new(params[:task])
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        require "fileutils"
        new_folder_path = File.join(upload_dir, "homework/src/tests", @task.id.to_s, @task.package.tr(".", "/"))
        new_file_path = File.join(new_folder_path, @task.task_file_file_name)
        FileUtils.mkdir_p(File.dirname(new_file_path))
        FileUtils.cp @task.task_file.path, new_file_path

        if ".zip" == File.extname(@task.task_file_file_name) 
          Zip::File.open(new_file_path) do |zip_file|
            zip_file.each do |entry|
              entry.extract( File.join(new_folder_path, entry.to_s) )
            end
          end
        end

        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
        format.xml { render xml: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.xml { render xml: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
        format.xml { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
        format.xml { render xml: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.works.destroy_all
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
      format.xml { head :no_content }
    end
  end
end
