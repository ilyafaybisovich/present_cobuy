class AddSplitPriceToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :split_price, :string
  end
end
