require 'rails_helper'

RSpec.describe Gift, type: :model do
  it { is_expected.to have_many :contributors }

  it 'it can calculate a split price' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com')
    gift.contributors.create(email: 'test2@test.com')
    gift = described_class.first
    expect(gift.split_price).to eq '100.0'
  end

  it 'it re-calculate a split price when a contributor is removed' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com')
    gift.contributors.create(email: 'test2@test.com')
    gift.contributors.first.destroy
    gift = described_class.first
    expect(gift.split_price).to eq '200.0'
  end
end
