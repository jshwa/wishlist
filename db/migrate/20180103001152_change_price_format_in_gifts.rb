class ChangePriceFormatInGifts < ActiveRecord::Migration[5.1]
  def change
    change_column :gifts, :price, :decimal, :precision => 8, :scale => 2
  end
end
