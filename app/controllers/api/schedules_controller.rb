class Api::SchedulesController < ApplicationController
  protect_from_forgery
  before_action :set_schedule, only: [:show, :update, :destroy]
  def index
    @s_show_list = []
    @s_hide_list = []
    @schedule_table =[]
    @schedules = Schedule.where(start_date: params[:start_date])
    s_rowspan = {}
    TIME_PITCH_NUM.times.map.each_with_index do |value, i|
      time = Time.zone.parse(params[:start_date]+" "+CONST_START_TIME)+TIME_PITCH.minutes*i
      s_column = {}
      s_column["time"] = time.strftime("%H") +":"+ time.strftime("%M")
      schedule =  @schedules.find_by(start_time: time)
      if schedule
        s_column["schedule"] = schedule
        task = Task.find(schedule.task_id)
        s_column["task"] = task
        s_column["rowspan"] = task.duration/TIME_PITCH
        
        s_rowspan["start_index"] = i;
        s_rowspan["rowspan"] = task.duration/TIME_PITCH
        # logger.debug("s_rowspanに代入完了")
        # logger.debug(s_rowspan.present?)
        # logger.debug(s_rowspan["start_index"])
        # logger.debug(s_rowspan["rowspan"])
      else
        s_column["schedule"] = ""
        s_column["task"] = ""
        # logger.debug(time)
        # logger.debug("スケジュールじゃない時")
        # logger.debug(s_rowspan.present?)
        if s_rowspan.present? 
          # logger.debug("i = #{i}")
          # logger.debug(s_rowspan)
          if i > s_rowspan["start_index"] && i < s_rowspan["start_index"] + s_rowspan["rowspan"]
            s_column["rowspan"] = 0
          else #s_rowspanは設定されていたけど、rowspan =0 にする範囲が終わった時
            s_column["rowspan"] = 1
          end
        else # rowspanで結合されない通常のrow
          s_column["rowspan"] = 1
        end
      end
      @schedule_table.push(s_column)
    end

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
    @schedule = Schedule.new(schedule_params)
    @schedule.end_time = @schedule.start_time + Task.find(@schedule.task_id).duration * 60
    if Schedule.exists?(task_id: params[:schedule][:task_id],start_date: params[:schedule][:start_date])
      @schedule.errors.add(:base, "このタスクは既にスケジュールに登録済みです。")
      return render json: @schedule.errors, status: :unprocessable_entity
    end

    current_day_schedules = Schedule.where(start_date: params[:schedule][:start_date])
    current_day_schedules.each do |current_day_schedule|
      if isDatetimeOverlap(@schedule.start_time,@schedule.end_time,current_day_schedule.start_time,current_day_schedule.end_time)
        @schedule.errors.add(:base, "その時間帯には既に別のタスクが登録されています。")
        return render json: @schedule.errors, status: :unprocessable_entity
      end
    end
    
   
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

  def isDatetimeOverlap(start1,end1,start2,end2)
    logger.debug("時間比較の確認")
    logger.debug("start1")
    logger.debug(start1)
    logger.debug("end1")
    logger.debug(end1)
    logger.debug("start2")
    logger.debug(start2)
    logger.debug("end2")
    logger.debug(end2)
    logger.debug("比較結果")
    logger.debug(start1 <= end2 && end1 >= start2)
    start1 < end2 && end1 > start2
  end
end
