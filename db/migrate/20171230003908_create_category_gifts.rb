class CreateCategoryGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :category_gifts do |t|
      t.integer :gifts_id
      t.integer :category_id

      t.timestamps
    end
  end
end
