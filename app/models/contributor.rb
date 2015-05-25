class Contributor < ActiveRecord::Base
  belongs_to :gift

  after_create :split_cost
  after_destroy :split_cost

  def split_cost
    gift = Gift.find(self.gift_id)
    count = gift.contributors.count
    gift.split_price = gift.item_price / count
    gift.save
  end

  def current_user?(current_user)
    self.email == current_user.email
  end

end
