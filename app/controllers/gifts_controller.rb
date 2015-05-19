require 'vacuum'

class GiftsController < ApplicationController
  def new
    @gift = Gift.new
  end

  def search

  end

  def amazon_search_results(keyword)
    request = Vacuum.new('GB')
    request.associate_tag = 'pridro02-20'
    response = request.item_search(
      query: {
        'Keywords' => keyword,
        'SearchIndex' => 'All',
        'Condition' => 'New',
        'Operation' => 'ItemSearch',
        'ResponseGroup' => 'Images,ItemAttributes,OfferSummary'
      }
    )
    response_hash = response.to_h
  end

  def format_search(response_hash)
    items = response_hash['ItemSearchResponse']['Items']['Item']
    results = []
    items.each do |value|
      result = { asin: (value.key?('ASIN') ? value['ASIN'] : nil),
                 image: ((h = value['MediumImage']) && h['URL']),
                 url_path: (value.key?('DetailPageURL') ? value['DetailPageURL'] : nil),
                 title: ((h = value['ItemAttributes']) && (h['Title'])),
                 price: ((h = value['OfferSummary']) && (j = h['LowestNewPrice']) && (j['FormattedPrice']))
               }
      results << result
    end
  end
end
