require 'rails_helper'

RSpec.describe Gift, type: :model do
  it { should have_many :contributors}
end