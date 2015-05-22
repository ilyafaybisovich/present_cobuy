require 'rails_helper'

RSpec.describe Gift, type: :model do
  it { is_expected.to have_many :contributors }
end