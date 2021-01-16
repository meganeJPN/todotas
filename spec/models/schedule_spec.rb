require 'rails_helper'
require 'securerandom'
RSpec.describe 'Scheduleモデルのテスト', type: :model do
  before do
    @user = create(:user)
    @task = create(:task, user_id: @user.id)
    @start_date = DateTime.now 
    @start_time = Time.zone.parse(@start_date.strftime("%Y-%m-%d")+" "+"09:00")
    @end_time = @start_time + @task.duration * 60
  end

  describe 'バリデーションのテスト' do
    context 'スケジュールのstart_dateが空の場合' do
      it 'バリデーションにひっかかる' do
      # binding.irb
        schedule = Schedule.new(start_date:"", start_time: @start_time, end_time: @end_time,task_id: @task.id, user_id: @user.id)
        expect(schedule).not_to be_valid
      end
    end
    context 'スケジュールのstart_timeが空の場合' do
      it 'バリデーションにひっかかる' do
        schedule = Schedule.new(start_date: @start_date, start_time: "", end_time: @end_time,task_id: @task.id, user_id: @user.id)
        expect(schedule).not_to be_valid
      end
    end
    context 'スケジュールのend_timeが空の場合' do
      it 'バリデーションにひっかかる' do
        schedule = Schedule.new(start_date: @start_date, start_time: @start_time, end_time: "",task_id: @task.id, user_id: @user.id)
        expect(schedule).not_to be_valid 
      end
    end
    context 'スケジュールのstart_date、start_time、end_timeに値が入っている場合' do
      it 'バリデーションが通る' do
        schedule = Schedule.new(start_date: @start_date, start_time: @start_time, end_time: @end_time,task_id: @task.id, user_id: @user.id)
        expect(schedule).to be_valid
      end
    end
  end
end