class Api::TasksController < ApplicationController
  protect_from_forgery
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = Task.order('updated_at DESC')
    @tasks_working = Task.where(completed: false).order('updated_at DESC')
    @tasks_finished = Task.where(completed: true)
    @tasks_assigned = Task.eager_load(:schedules).where(tasks: {completed: false},schedules: {start_date: params[:current_date]})
    tasks_not_assigned_nil = Task.eager_load(:schedules).where(tasks: {completed: false}).where(schedules: {start_date: nil})
    tasks_not_assigned_other = Task.eager_load(:schedules).where(tasks: {completed: false}).where.not(schedules: {start_date: params[:current_date]})
    @tasks_not_assigned = tasks_not_assigned_nil + tasks_not_assigned_other;
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
    # タスク完了処理
    return render :show, status: :ok if params[:task][:completed] && @task.update(completed: true)
    
    if Schedule.exists?(task_id: @task.id)
      @task.errors.add(:base, "そのタスクはスケジュールにアサインされているため更新できません。")
      return render json: @task.errors, status: :unprocessable_entity
    end
    if @task.update(task_params)
      render :show, status: :ok
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def show
    @assigned = Schedule.exists?(task_id: @task.id)
  end

  def destroy
    if Schedule.exists?(task_id: @task.id)
      if @task.completed && @task.destoy
        return :show, status: :ok
      else
        @task.errors.add(:base, "そのタスクはスケジュールにアサインされているため削除できません。")
        return render json: @task.errors, status: :unprocessable_entity
      end
    end
    render :show, status: :ok if @task.destroy
  end

  private
  def task_params
    params.fetch(:task, {}).permit(:content, :comment, :duration, :completed)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end