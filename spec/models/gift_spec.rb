RSpec.describe Gift, type: :model do
  it { is_expected.to have_many :contributors }

  it 'it can calculate a split price' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com')
    gift.contributors.create(email: 'test2@test.com')
    gift = described_class.first
    expect(gift.split_price).to eq '100.0'
  end

  it 'it re-calculates a split price when a contributor is removed' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com')
    gift.contributors.create(email: 'test2@test.com')
    gift.contributors.first.destroy
    gift = described_class.first
    expect(gift.split_price).to eq '200.0'
  end

  it 'calculates the number of contributers that have paid' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com', token: "ffndjfnrjfgnw")
    gift.contributors.create(email: 'test2@test.com')
    gift = described_class.first
    expect(gift.paid_contributors).to eq 1
  end

  it 'calculates the % contribution' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com', token: "ffndjfnrjfgnw")
    gift.contributors.create(email: 'test2@test.com')
    gift = described_class.first
    expect(gift.percentage_complete).to eq 50
  end

  it 'can respond with whether the contribution is complete' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com', token: "ffndjfnrjfgnw")
    gift.contributors.create(email: 'test2@test.com')
    gift = described_class.first
    expect(gift.all_contributed?).to be_falsy
  end

  it 'can respond with whether the contribution is complete' do
    gift = described_class.create(item_price: 200.0)
    gift.contributors.create(email: 'test@test.com', token: "ffndjfnrjfgnw")
    gift.contributors.create(email: 'test2@test.com', token: "ffndjfnrjfgnw")
    gift = described_class.first
    expect(gift.all_contributed?).to be_truthy
  end
end
