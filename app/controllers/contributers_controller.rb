class ContributersController < ApplicationController
  def pay
    @contributor = Contributor.find_by(params[:id])
    @contributor.token = "fdmkfkganro"
    @contributor.save
    render json: @contributor.to_json
  end
end
