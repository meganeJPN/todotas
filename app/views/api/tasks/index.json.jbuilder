json.set! :tasks do
  json.array! @tasks do |task|
    json.extract! task, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end

json.set! :tasks_assigned do
  json.array! @tasks_assigned do |task_assigned|
    json.extract! task_assigned, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end

json.set! :tasks_not_assigned do
  json.array! @tasks_not_assigned do |task_not_assigned|
    json.extract! task_not_assigned, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end