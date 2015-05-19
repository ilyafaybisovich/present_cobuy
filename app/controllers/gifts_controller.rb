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
end
