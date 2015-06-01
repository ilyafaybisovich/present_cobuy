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
    return unless Gift.exists? id: [params[:id]]
    return unless user_signed_in?
    @gift = Gift.find params[:id]
    @contributors = @gift.contributors
    @organiser = User.find @gift.user_id
    @days_left = days_left
    @current_user_giftbox = current_user_giftbox?
  end

  def current_user_giftbox?
    @contributors.any? do |contributor|
      contributor.email == current_user.email
    end
  end

  def search
    render json: format_search(amazon_search_results(params[:keyword]))
  end

  def amazon_search_results keyword
    request = Vacuum.new 'GB'
    request.associate_tag = 'pridro02-20'
    response = request.item_search(
      query: {
        'Keywords' => keyword, 'SearchIndex' => 'All',
        'Condition' => 'New', 'Operation' => 'ItemSearch',
        'ResponseGroup' => 'Images,ItemAttributes,OfferSummary'
      }
    )
    response_hash = response.to_h
  end

  def format_search response_hash
    return {} unless response_hash['ItemSearchResponse']['Items'].key? 'Item'
    items = response_hash['ItemSearchResponse']['Items']['Item']
    items.inject([]) do |array, value|
      array << { "asin": extract_asin(value),
                 "image": extract_image(value),
                 "url_path": extract_url_path(value),
                 "title": extract_title(value),
                 "price": extract_price(value)
      }
    end
  end

  private

  def days_left
    days_count = (@gift.delivery_date - DateTime.now).to_i
    days_count < 0 ? 0 : days_count
  end

  def gift_params
    params.require(:gift).permit :title, :recipient,
                                 :delivery_date, :item, :item_price,
                                 :description, :item_image, :item_url,
                                 :ship_name, :ship_surname, :ship_add1,
                                 :ship_add2, :ship_city, :ship_county,
                                 :ship_pcode,
                                 contributors_attributes: [
                                   :id, :email, :_destroy
                                 ]
  end

  def extract_asin value
    (value.key?('ASIN') ? value['ASIN'] : nil).to_s
  end

  def extract_image value
    ((h = value['MediumImage']) && h['URL'].sub(
      'http://ecx.images-amazon.com/',
      'https://images-na.ssl-images-amazon.com/')).to_s
  end

  def extract_url_path value
    (value.key?('DetailPageURL') ? value['DetailPageURL'] : nil).to_s
  end

  def extract_title value
    ((h = value['ItemAttributes']) && (h['Title'])).to_s
  end

  def extract_price value
    (
      (h = value['OfferSummary']) &&
      (j = h['LowestNewPrice']) &&
      (j['FormattedPrice'])
    ).to_s
  end
end
