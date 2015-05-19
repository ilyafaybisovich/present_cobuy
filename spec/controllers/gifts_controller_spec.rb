require 'hash_helper'

RSpec.describe GiftsController, type: :controller do
  xit'has to return a hash with a list of products' do
    # p subject.amazon_search_results('macbook pro')
    expect(subject.amazon_search_results('macbook pro')).to eq SEARCH_HASH
  end

  it 'returns a search format hash' do
    expect(subject.format_search(subject.amazon_search_results('Macbook Pro'))).to be_an Array
  end
end
