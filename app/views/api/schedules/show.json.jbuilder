json.set! :schedule do
  json.extract! @schedule, :id, :start_date, :start_time,  :end_time, :created_at, :updated_at
end