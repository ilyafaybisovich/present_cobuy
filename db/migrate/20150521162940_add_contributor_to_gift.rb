class AddContributorToGift < ActiveRecord::Migration
  def change
    add_column :gifts, :contributor_id, :integer
  end
end
