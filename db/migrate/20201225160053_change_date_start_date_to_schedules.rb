class ChangeDateStartDateToSchedules < ActiveRecord::Migration[5.2]
  def up
    remove_column :schedules, :start_time
    remove_column :schedules, :end_time
    add_column :schedules, :start_time, :datetime
    add_column :schedules, :end_time, :datetime
  end
  def down 
    remove_column :schedules, :start_time
    remove_column :schedules, :end_time
    add_column :schedules, :start_time, :time
    add_column :schedules, :end_time, :time
  end
end
