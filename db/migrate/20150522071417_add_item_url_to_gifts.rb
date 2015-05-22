class AddItemUrlToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :item_url, :text
  end
end
