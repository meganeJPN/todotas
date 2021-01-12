json.set! :schedule do
  json.extract! @schedule, :id, :start_date, :start_time, :end_time, :task_id, :created_at, :updated_at
end

json.set! :schedule_table do
  json.array! @schedule_table
end

json.set! :task do
  json.extract! @task, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
end
