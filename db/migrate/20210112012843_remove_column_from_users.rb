class RemoveColumnFromUsers < ActiveRecord::Migration[5.2]
  def up
    remove_column :users, :reset_password_token
    remove_column :users, :reset_password_sent_at
    remove_column :users, :allow_password_change
    remove_column :users, :remember_created_at
    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :unconfirmed_email
    remove_column :users, :nickname
    remove_column :users, :image
    # remove_index :users, column: :confirmation_token
    # remove_index :users, column: :reset_password_token
  end

  def down
    add_column :users, :reset_password_token, :string
    add_column :users, :reset_password_sent_at, :datetime
    add_column :users, :allow_password_change, :boolean
    add_column :users, :remember_created_at, :datetime
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string
    add_column :users, :nickname, :string
    add_column :users, :image, :string
    add_index :users, :confirmation_token
    add_index :users, :reset_password_token
  end
end
