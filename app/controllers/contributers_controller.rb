class ContributersController < ApplicationController
  def pay
    @contributor = Contributor.find_by(params[:id])
    @contributor.token = "fdmkfkganro"
    @contributor.save

    respond_to do |format|
      format.json { render json: @contributor.to_json }
      format.js
    end
  end
end
