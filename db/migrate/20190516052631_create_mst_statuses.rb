class CreateMstStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :mst_statuses do |t|
      t.text :status_name

      t.timestamps
    end
  end
end
