class UsersController < ApplicationController
  def index
    redirect_to "/users/#{current_user.id}" if user_signed_in?
  end

  def show
    return unless user_signed_in?
    @user = User.find current_user.id
    contributors = Contributor.where email: @user.email
    @gifts = []
    contributors.each do |contributor|
      @gifts << Gift.find(contributor.gift_id)
    end
  end
end
