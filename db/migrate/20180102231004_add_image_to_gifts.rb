class AddImageToGifts < ActiveRecord::Migration[5.1]
  def change
    add_column :gifts, :image, :string
  end
end
