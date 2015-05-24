class UsersController < ApplicationController
  def index
  end

  def list
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @gifts = Gift.where user_id: @user.id
  end
end
