class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :url
      t.string :description
      t.integer :price
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
