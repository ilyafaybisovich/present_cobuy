class AddItemPriceToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :item_price, :float
  end
end
