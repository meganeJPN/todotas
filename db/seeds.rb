task01 = Task.create!(content: 'Sample Task', duration: 120)
Schedule.create!(start_date: DateTime.now, start_time:'15:00', end_time:'17:00',task_id: task01.id)

task02 = Task.create!(content: 'Sample Task', duration: 30, completed: true) 
Schedule.create!(start_date: DateTime.now, start_time:'10:00', end_time:'10:30',task_id: task02.id)

task03 = Task.create!(content: 'Sample Task', duration: 45)
Schedule.create!(start_date: DateTime.now, start_time:'17:30', end_time:'18:15',task_id: task03.id)

task04 = Task.create!(content: 'Sample Task', duration: 30, completed: true) 
Schedule.create!(start_date: DateTime.now, start_time:'08:15', end_time:'08:45',task_id: task04.id)
