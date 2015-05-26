class AddPurchaseTokenToGifts < ActiveRecord::Migration
  def change
    add_column :gifts, :purchase_token, :string
  end
end
