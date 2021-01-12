class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|
      t.date :start_date
      t.time :start_time
      t.time :end_time
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
