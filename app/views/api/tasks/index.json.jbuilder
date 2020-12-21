json.set! :tasks do
  json.array! @tasks do |task|
    json.extract! task, :id, :content, :comment, :duration, :completed, :created_at, :updated_at
  end
end