class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.text :content
      t.text :title
      t.references :mst_status, foreign_key: true
      t.references :category, foreign_key: true
      t.timestamp :post_time
      t.text :thumnail_url

      t.timestamps
    end
  end
end
