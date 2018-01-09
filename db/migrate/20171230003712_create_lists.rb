class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.string :description, default: "This is my wishlist. There are many like it, but this one is mine."

      t.timestamps
    end
  end
end
