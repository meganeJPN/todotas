class Api::SchedulesController < ApplicationController
  protect_from_forgery
  before_action :set_schedule, only: [:show, :update, :destroy]
  def index
    @s_show_list = []
    @s_hide_list = []
    @schedules = Schedule.where(start_date: params[:start_date])
    @schedules.each do |schedule|
      s_show={}
      s_show[:row_id] = schedule.start_time.strftime("%H") + schedule.start_time.strftime("%M")
      s_show[:task] = Task.find(schedule.task_id)
      s_show[:schedule] = schedule
      s_show[:rowspan] = Task.find(schedule.task_id).duration / 15
      @s_show_list.push(s_show)
      (Task.find(schedule.task_id).duration/15-1).times.map.each_with_index{|i| @s_hide_list.push((schedule.start_time+15.minutes+15.minutes*i).strftime("%H")+(schedule.start_time+15.minutes+15.minutes*i).strftime("%M"))}
    end
  end

  def create
    binding.irb
    # if Schedule.where(task_id: params[:schedule][:task_id]).where(start_date: params[:schedule][:start_date])
    #end
    @schedule = Schedule.new(schedule_params)
    @schedule.end_time = @schedule.start_time + Task.find(@schedule.task_id).duration * 60
    if @schedule.save
      render :show, status: :created
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  def update
    if @schedule.update(schedule_params[:id])
      render :show, status: :ok
    else
      render json: @schedule.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @schedule.destroy
      render status: 200, json: {status:200}
    end
  end

  private
  def schedule_params
    params.fetch(:schedule, {}).permit(:start_date, :start_time, :end_time,:task_id)
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
end
