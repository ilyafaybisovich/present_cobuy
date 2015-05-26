class RemoveSpliPriceFromContributors < ActiveRecord::Migration
  def change
    remove_column :contributors, :split_price, :float
  end
end
