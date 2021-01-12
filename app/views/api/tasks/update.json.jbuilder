json.set! :task do
  json.extract! @task, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
end