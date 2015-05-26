RSpec.describe Contributor, type: :model do
  it { is_expected.to belong_to :gift }
end
