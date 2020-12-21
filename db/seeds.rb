3.times { Task.create!(content: 'Sample Task', duration: 45) }
2.times { Task.create!(content: 'Sample Task', duration: 30, completed: true) }