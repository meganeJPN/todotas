class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :content, null: false
      t.text :comment
      t.integer :duration, null: false
      t.boolean :completed, default: false, null: false

      t.timestamps
    end
  end
end
