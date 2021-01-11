json.set! :schedules do
  json.array! @schedules do |schedule|
    json.extract! schedule, :id, :start_date, :start_time, :end_time, :task_id, :created_at, :updated_at
  end
end
json.set! :schedule_table do
  json.array! @schedule_table
end