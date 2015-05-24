class AddTokenToContributors < ActiveRecord::Migration
  def change
    add_column :contributors, :token, :string
  end
end
