require 'mock_helper'

RSpec.describe GiftsController, type: :controller do
  context 'Receives a response from Amazon –' do
    it 'returns a hash with a list of products' do
      expect(subject.amazon_search_results('macbook pro')).to be_a Hash
    end

    it 'returns an empty hash when no products found' do
      expect(subject.amazon_search_results('fejiowfjFwjeopfjewfjP'))
        .to be_a Hash
    end
  end

  context 'Formats the response from Amazon –' do
    it 'returns the correct number of items' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result.count).to eq 10
    end

    it 'returns the correct number of key-value pairs in the hash' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result[0].count).to eq 5
    end

    it 'returns the correct value for an ASIN' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result[0][:asin]).to eq 'B008BEYEL8'
    end

    it 'returns the correct value for an image path' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result[1][:image]).to eq(
        'http://ecx.images-amazon.com/images/I/31bMAM%2BtIDL._SL160_.jpg')
    end

    it 'returns the correct value for a URL path' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result[2][:url_path]).to eq(
        'http://www.amazon.co.uk/Apple-MacBook-15-4-inch-Laptop-c'\
        'ore_i7/dp/B00MB5BOPM%3Fpsc%3D1%26SubscriptionId%3DAKIAIR'\
        'BKK35SHPHUR23Q%26tag%3Dpridro02-20%26linkCode%3Dxm2%26ca'\
        'mp%3D2025%26creative%3D165953%26creativeASIN%3DB00MB5BOPM')
    end

    it 'returns the correct value for a title' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result[3][:title]).to eq(
        'Apple MacBook 15.4-inch  Laptop '\
        '(Intel core_i7 2.5GHz, 16GB RAM, Mac OS X)')
    end

    it 'returns the correct value for a price' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result[4][:price]).to eq '£860.00'
    end

    it 'returns nil when a key is not available in the Amazon response' do
      formatted_result = subject.format_search AMAZON_SEARCH_HASH
      expect(formatted_result[7][:price]).to eq ''
    end
  end
end
