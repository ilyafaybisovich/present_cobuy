class Contributor < ActiveRecord::Base
  belongs_to :gift

  after_create :split_cost

  def split_cost
    gift = Gift.find(self.gift_id)
    count = gift.contributors.count
    gift.split_price = gift.item_price / count
    gift.save
  end
end
