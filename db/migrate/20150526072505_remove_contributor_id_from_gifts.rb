class RemoveContributorIdFromGifts < ActiveRecord::Migration
  def change
    remove_column :gifts, :contributor_id, :integer
  end
end
