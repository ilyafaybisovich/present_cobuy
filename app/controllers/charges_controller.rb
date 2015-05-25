class ChargesController < ApplicationController

  def new
  end

  def create

    gift = Gift.find(params[:gift_id])
    contributor = Contributor.find(params[:contributor_id])

    @amount = 500

    customer = Stripe::Customer.create(
      email: 'example@stripe.com',
      card: params[:stripeToken])

    contributor.token = params[:stripeToken]
    contributor.save
    # contributor.purchase_amount = @amount

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Prezzy Payment',
      currency: 'gbp')

    redirect_to pay_gift_contributor_path(gift, contributor)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
