class AddUserIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_id, :text
    add_index :users, :user_id, unique: true
  end
end
