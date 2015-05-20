require 'vacuum'

class GiftsController < ApplicationController
  def new
    @gift = Gift.new
  end

  def create
    @gift = Gift.create gift_params
    redirect_to '/gifts'
  end

  def gift_params
    params.require(:gift).permit(:title,
                                 :recipient,
                                 :recipient_address,
                                 :delivery_date)
  end

  def index
    @gifts = Gift.all
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
    items.inject([]) do |array, value|
      array << { asin: (value.key?('ASIN') ? value['ASIN'] : nil),
                 image: ((h = value['MediumImage']) && h['URL']),
                 url_path: (value.key?('DetailPageURL') ? value['DetailPageURL'] : nil),
                 title: ((h = value['ItemAttributes']) && (h['Title'])),
                 price: ((h = value['OfferSummary']) && (j = h['LowestNewPrice']) && (j['FormattedPrice']))
               }
    end
  end
end
