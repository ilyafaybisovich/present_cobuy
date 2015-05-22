class AddItemImageToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :item_image, :string
  end
end
