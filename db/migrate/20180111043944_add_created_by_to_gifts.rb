class AddCreatedByToGifts < ActiveRecord::Migration[5.1]
  def change
    add_column :gifts, :created_by, :integer
  end
end
