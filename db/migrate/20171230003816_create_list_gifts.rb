class CreateListGifts < ActiveRecord::Migration[5.1]
  def change
    create_table :list_gifts do |t|
      t.integer :gift_id
      t.integer :list_id

      t.timestamps
    end
  end
end
