json.set! :schedules do
  json.array! @schedules do |schedule|
    json.extract! schedule, :id, :start_date, :start_time, :end_time, :created_at, :updated_at
  end
end