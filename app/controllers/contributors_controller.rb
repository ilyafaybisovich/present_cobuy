class ContributorsController < ApplicationController
  def pay
    @contributor = Contributor.find(contributor_params[:id])
    @gift = Gift.find(contributor_params[:gift_id])
    @amount = (@gift.split_price.to_f * 100).to_i

    customer = Stripe::Customer.create(
      email: contributor_params[:stripeEmail],
      card: contributor_params[:stripeToken])

    @contributor.token = customer.id
    @contributor.save

    redirect_to gift_path(@gift)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    @contributor.token = nil
  end

  def contributor_params
    params.permit(:stripeToken,
                  :stripeTokenType,
                  :stripeEmail,
                  :gift_id,
                  :id)
  end
end
