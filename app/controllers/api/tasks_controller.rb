class Api::TasksController < ApplicationController
  protect_from_forgery
  before_action :set_task, only: [:show, :update, :destroy]
  before_action :authenticate_v1_user!
  before_action :not_login_redirect_to_new_session

  # GET /tasks
  def index
    @tasks = Task.eager_load(:users).where(users: {id: current_v1_user.id}).order(created_at: "DESC")
    @tasks_working = Task.where(completed: false).order('updated_at DESC')
    @tasks_finished = Task.where(completed: true)
    @tasks_assigned = Task.eager_load(:schedules).where(tasks: {completed: false},schedules: {start_date: params[:current_date]})
    tasks_not_assigned_nil = Task.eager_load(:schedules).where(tasks: {completed: false}).where(schedules: {start_date: nil})
    tasks_not_assigned_other = Task.eager_load(:schedules).where(tasks: {completed: false}).where.not(schedules: {start_date: params[:current_date]})
    @tasks_not_assigned = tasks_not_assigned_nil + tasks_not_assigned_other;
  end

  # POST /tasks
  def create
    @task = current_v1_user.tasks.build(task_params)

    if @task.save
      render :show, status: :created
    else
      render json: {errors: @task.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    # タスク完了処理
    return render :show, status: :ok if params[:task][:completed] && @task.update(completed: true)
    return render json: {errors:  @task.errors.add(:base, "そのタスクはスケジュールにアサインされているため更新できません。")}, status: :unprocessable_entity if Schedule.exists?(task_id: @task.id) 
    # return render json: @task.errors.add(:base, "そのタスクはスケジュールにアサインされているため更新できません。"), status: :unprocessable_entity if Schedule.exists?(task_id: @task.id) 
    return render json: {errors: @tasks.errors.add(:base, "そのタスクは完了しているため更新できません。")}, status: :unprocessable_entity if @task.completed
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
        return render json: {errors: @task.errors.add(:base, "そのタスクはスケジュールにアサインされているため削除できません。")}, status: :unprocessable_entity
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

  def not_login_redirect_to_new_session
    redirect_to new_v1_user_session_path unless v1_user_signed_in?
  end
end