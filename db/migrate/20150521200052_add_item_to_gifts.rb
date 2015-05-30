class AddItemToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :item, :string
  end
end
