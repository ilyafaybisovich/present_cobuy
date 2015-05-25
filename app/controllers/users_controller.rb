class UsersController < ApplicationController
  def index
    redirect_to "/users/#{current_user.id}" if user_signed_in?
  end

  def list
    @users = User.all
  end

  def show
    return unless user_signed_in?
    @user = User.find params[:id]
    @gifts = Gift.where user_id: @user.id
  end
end
