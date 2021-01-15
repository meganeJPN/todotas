json.set! :schedules do
  json.array! @schedules do |schedule|
    json.extract! schedule, :id, :start_date, :start_time, :end_time, :task_id, :created_at, :updated_at
  end
end
json.set! :schedule_table do
  json.array! @schedule_table
end
json.set! :tasks_not_assigned_other do
  json.array! @tasks_assigned do |task_assigned|
    json.extract! task_assigned, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end