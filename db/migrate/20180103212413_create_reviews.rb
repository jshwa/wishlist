class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :stars
      t.text :comment
      t.integer :user_id
      t.integer :gift_id

      t.timestamps
    end
  end
end
