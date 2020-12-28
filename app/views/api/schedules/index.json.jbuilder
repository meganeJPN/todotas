json.set! :schedules do
  json.array! @schedules do |schedule|
    json.extract! schedule, :id, :start_date, :start_time, :end_time, :created_at, :updated_at
  end
end
json.set! :s_show_list do
  json.array! @s_show_list do |s_show|
    json.extract! s_show, :row_id, :task, :schedule, :rowspan
  end
end
json.set! :s_hide_list do
  json.array! @s_hide_list
end
json.set! :schedule_table do
  json.array! @schedule_table
end