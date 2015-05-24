class ContributorsController < ApplicationController
  def pay
    @contributor = Contributor.find(params[:id])
    @contributor.token = "fdmkfkganro"
    @contributor.save
    @gift = Gift.find(params[:gift_id])

    respond_to do |format|
      format.json { render json: @contributor.to_json }
      format.js
    end
  end
end
