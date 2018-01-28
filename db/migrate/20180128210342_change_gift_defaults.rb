class ChangeGiftDefaults < ActiveRecord::Migration[5.1]
  def change
    change_column_default :gifts, :url, nil
    change_column_default :gifts, :image, "default_gift.jpg"
  end
end
