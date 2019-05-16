class ChangeColumnToComments < ActiveRecord::Migration[5.2]
  def change
    change_column :comments, :block_flg, :text, null: false, default: 0
  end
end
