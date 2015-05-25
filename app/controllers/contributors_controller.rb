class ContributorsController < ApplicationController
  def pay
    @contributor = Contributor.find(contributor_params[:id])
    @contributor.token = "fdmkfkganro"
    @contributor.save
    @gift = Gift.find(contributor_params[:gift_id])

    @amount = 500 # @gift.split_price

    customer = Stripe::Customer.create(
      email: 'example@stripe.com',
      card: contributor_params[:stripeToken])

    # contributor.token = params[:stripeToken]
    # contributor.purchase_amount = @amount

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Prezzy Payment',
      currency: 'gbp')

    # respond_to do |format|
    #   # format.json { render json: @contributor.to_json }
    #   format.js
    # end
    flash[:notice] = "Payment Successful"
    redirect_to gift_path(@gift)

  rescue Stripe::CardError => e
    flash[:error] = e.message
  end

  def contributor_params
    params.permit(:stripeToken,
                  :stripeTokenType,
                  :stripeEmail,
                  :gift_id,
                  :id)
  end
end
