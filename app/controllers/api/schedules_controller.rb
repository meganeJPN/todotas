class Api::SchedulesController < ApplicationController
  protect_from_forgery
  before_action :set_schedule, only: [:show, :update, :destroy]
  def index
    @schedules = Schedule.where(start_date: params[:start_date])
  end

  def create
    @schedule = Schedule.new(schedule_params)

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
    params.fetch(:schedule, {}).permit(:start_date, :start_time, :end_time)
  end

  def set_schedule
    @schedule = Schedule.find(params[:id])
  end
end
