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
    p items[7]['ASIN']
    p items[7]['MediumImage']['URL']
    p items[7]['DetailPageURL']
    p items[7]['ItemAttributes']['Title']
    p items[7]['OfferSummary']['LowestNewPrice']['FormattedPrice']
    results = []
    items.each do |value|
      result = { asin: value.has_key?('ASIN') ? value['ASIN'] : nil,
                 image: value.has_key?('MediumImage']['URL'] ? value.'MediumImage']['URL'] : nil,
                 url_path: value.has_key?('DetailPageURL') ? value['DetailPageURL'] : nil,
                 title: value.has_key?()  ? value['ItemAttributes']['Title'] : nil,
                 price: value.has_key?() ? value['OfferSummary']['LowestNewPrice']['FormattedPrice'] : nil
               }
      # p value
      if value.has_key?('ASIN')
        results << result
      else
      return results if results.count == 7
    end
  end
end
