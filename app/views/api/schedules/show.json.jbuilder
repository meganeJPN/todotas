json.set! :schedule do
  json.extract! @schedule, :id, :start_date, :start_time, :end_time, :task_id, :created_at, :updated_at
end

json.set! :schedule_table do
  json.array! @schedule_table
end

json.set! :task do
  json.extract! @task, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
end

json.set! :tasks_assigned do
  json.array! @tasks_assigned do |task_assigned|
    json.extract! task_assigned, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end

json.set! :tasks_not_assigned_nil do
  json.array! @tasks_not_assigned_nil do |task_not_assigned_nil|
    json.extract! task_not_assigned_nil, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end