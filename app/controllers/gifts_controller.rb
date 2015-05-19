class GiftsController < ApplicationController
  def new
    @gift = Gift.new
  end
end
