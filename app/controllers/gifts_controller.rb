require 'vacuum'
require 'json'

class GiftsController < ApplicationController
  def new
    @gift = Gift.new
  end

  def create
    new_params = gift_params
    new_params[:user_id] = current_user.id
    @gift = Gift.create new_params
    @gift.contributors.create(gift_id: @gift.id, email: current_user.email)

    redirect_to "/gifts/#{@gift.id}"
  end

  def show
    @gift = Gift.find params[:id]
    @contributors = @gift.contributors
    @organiser = User.find(@gift.user_id).email
  end

  def gift_params
    params.require(:gift).permit :title,
                                 :recipient,
                                 :recipient_address,
                                 :delivery_date,
                                 :item,
                                 :item_price,
                                 :description,
                                 :item_image,
                                 :item_url,
                                 contributors_attributes: [
                                   :id,
                                   :email,
                                   :_destroy
                                 ]
  end

  def search
    render json: format_search(amazon_search_results(params[:keyword]))
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
    if response_hash['ItemSearchResponse']['Items'].key?('Item')
      items = response_hash['ItemSearchResponse']['Items']['Item']
      return items.inject([]) do |array, value|
               array << { "asin": (value.key?('ASIN') ? value['ASIN'] : nil).to_s,
                          "image": ((h = value['MediumImage']) && h['URL']).to_s,
                          "url_path": (value.key?('DetailPageURL') ? value['DetailPageURL'] : nil).to_s,
                          "title": ((h = value['ItemAttributes']) && (h['Title'])).to_s,
                          "price": ((h = value['OfferSummary']) && (j = h['LowestNewPrice']) && (j['FormattedPrice'])).to_s
                         }
             end
    else
      return {}
    end
  end
end
