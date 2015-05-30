class AddSplitPriceToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :split_price, :float
  end
end
