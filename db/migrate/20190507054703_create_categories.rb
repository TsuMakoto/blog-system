class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.text :name
      t.text :parent_category_id

      t.timestamps
    end
  end
end
