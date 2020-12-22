class Api::TasksController < ApplicationController
  protect_from_forgery
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.order('updated_at DESC')
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render :show, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render :show, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy 
      render status: 200, json: {status: 200}
    end


  end

  private
  def task_params
    params.fetch(:task, {}).permit(:content, :comment, :duration, :completed)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end