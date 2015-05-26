require 'httparty'

class ContributorsController < ApplicationController
  def pay
    @contributor = Contributor.find(contributor_params[:id])
    @gift = Gift.find(contributor_params[:gift_id])
    @amount = (@gift.split_price.to_f * 100).to_i
    create_stripe_customer(@contributor,
                           contributor_params[:stripeEmail],
                           contributor_params[:stripeToken])
    stripe_payments(@gift)
    flash[:notice] = "Payment Successful"
    redirect_to gift_path(@gift)
  rescue Stripe::CardError => e
    @contributor.token = nil
    flash[:error] = e.message
  end

  def contributor_params
    params.permit(:stripeToken,
                  :stripeTokenType,
                  :stripeEmail,
                  :gift_id,
                  :id)
  end

  private

  def create_stripe_customer(contributor, email, token)
    customer = Stripe::Customer.create(
      email: email,
      card: token)
    contributor.token = customer.id
    contributor.save
  end

  def stripe_payments(gift)
    if gift.all_contributed?
      gift.contributors.each do |contributor|
        charge = Stripe::Charge.create(
          customer: contributor.token,
          amount: @amount,
          description: 'Prezzy Payment',
          currency: 'gbp')
      end
      # contributor.purchase_amount = @amount
      zinc_post(gift)
    end
  end

  def zinc_post(gift)
    zinc_object = {
      client_token: ENV['ZINC_CLIENT_TOKEN'],
      retailer: "amazon_uk",
      products: [{ product_id: gift.item, quantity: 1 }],
      maxprice: 0, #needs to be set to gift.item_price on live
      shipping_address: {
        first_name: gift.ship_name,
        last_name: gift.ship_surname,
        address_line1: gift.ship_add1,
        address_line2: gift.ship_add2,
        zip_code: gift.ship_pcode,
        city: gift.ship_city,
        state: gift.ship_county,
        country: "UK",
        phone_number: ENV['ZINC_BAD_PHONE']
      },
      is_gift: true,
      gift_message: gift.title,
      shipping_method: "cheapest",
      payment_method: {
        name_on_card: ENV['ZINC_CARD_HOLDER'],
        number: ENV['ZINC_CARD_NUMBER'],
        security_code: ENV['ZINC_CODE'],
        expiration_month: ENV['ZINC_EXPIRY_MONTH'].to_i,
        expiration_year: ENV['ZINC_EXPIRY_YEAR'].to_i,
        use_gift: false
      },
      billing_address: {
        first_name: ENV['ZINC_BAD_NAME'],
        last_name: ENV['ZINC_BAD_SUR'],
        address_line1: ENV['ZINC_BAD_ADD'],
        address_line2: "",
        zip_code: ENV['ZINC_BAD_PCODE'],
        city: ENV['ZINC_BAD_CITY'],
        state: ENV['ZINC_BAD_STATE'],
        country: "UK",
        phone_number: ENV['ZINC_BAD_PHONE']
      },
      retailer_credentials: {
        email: ENV['ZINC_EMAIL'],
        password: ENV['ZINC_CREDENTIALS']
      },
      client_notes: {
        our_internal_order_id: gift.id
      }
    }
    response = HTTParty.post('https://api.zinc.io/v0/order',
                             body: zinc_object.to_json,
                             headers: { 'Content-Type' => 'application/json' })
    gift.purchase_token = response["request_id"]
    p gift
  end
end
