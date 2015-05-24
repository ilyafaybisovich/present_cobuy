class AddUserIdToGifts < ActiveRecord::Migration
  def change
    add_reference :gifts, :user, index: true, foreign_key: true
  end
end
