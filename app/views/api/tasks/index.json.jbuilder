json.set! :tasks_working do
  json.array! @tasks_working do |task|
    json.extract! task, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end

json.set! :tasks_finished do
  json.array! @tasks_finished do |task|
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