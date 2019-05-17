class ChangeColumnTypeToComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :block_flg, :text
    add_column :comments, :block_flg, :integer, null: false, default: 0
  end
end
