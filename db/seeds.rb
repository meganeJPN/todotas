5.times do |n|
  User.create!(
    email: "test#{n + 1}@test.jp",
    name: "テストユーザー#{n + 1}",
    password:"123456"
  )
end



  current = -2
  4.times{ |i|
    today = DateTime.now + current + i
    User.all.each do |user|
      task01 = user.tasks.create!(
        content: "メールチェック#{today.strftime("%Y-%m-%d")}",
        duration: 30,
        comment: 'メールを確認する。重要なメールには返信する。'
      )
      task02 = user.tasks.create!(
        content: "定例ミーティング#{today.strftime("%Y-%m-%d")}",
        duration: 60,
        comment: 'プロジェクトの進捗状況の報告。'
      )
      task03 = user.tasks.create!(
        content: "認証機能のシステムテスト#{today.strftime("%Y-%m-%d")}",
        duration: 90,
        comment: 'テスト項目01〜10を消化する'
      ) 
      
      start_time = Time.zone.parse(today.strftime("%Y-%m-%d")+" "+"09:00")
      Schedule.create!(start_date: today, start_time: start_time, end_time: start_time + task01.duration * 60, task_id: task01.id, user_id: user.id)
      start_time = Time.zone.parse(today.strftime("%Y-%m-%d")+" "+"13:00")
      Schedule.create!(start_date: today, start_time: start_time, end_time: start_time + task02.duration * 60, task_id: task02.id, user_id: user.id)
      start_time = Time.zone.parse(today.strftime("%Y-%m-%d")+" "+"15:00")
      Schedule.create!(start_date: today, start_time: start_time, end_time: start_time + task03.duration * 60, task_id: task03.id, user_id: user.id)
    end
   
  }
# task01 = Task.create!(content: 'Sample Task', duration: 120)
# Schedule.create!(start_date: DateTime.now, start_time:'15:00', end_time:'17:00',task_id: task01.id)

# task02 = Task.create!(content: 'Sample Task', duration: 30, completed: true) 
# Schedule.create!(start_date: DateTime.now, start_time:'10:00', end_time:'10:30',task_id: task02.id)

# task03 = Task.create!(content: 'Sample Task', duration: 45)
# Schedule.create!(start_date: DateTime.now, start_time:'17:30', end_time:'18:15',task_id: task03.id)

# task04 = Task.create!(content: 'Sample Task', duration: 30, completed: true) 
# Schedule.create!(start_date: DateTime.now, start_time:'08:15', end_time:'08:45',task_id: task04.id)
