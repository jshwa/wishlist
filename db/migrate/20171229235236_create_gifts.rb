class CreateGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :gifts do |t|
      t.string :name
      t.string :url, default: "default_gift.jpg"
      t.string :description
      t.decimal :price, precision: 8, scale: 2
      t.string :image
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end
