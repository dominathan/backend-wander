class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: @current_user.friends, status: 200
  end

  def create
    user = User.find_by(id: params[:id])
    @current_user.friend_request(user)
  end

  def accept
    @current_user.accept_request(user)
  end

  def decline
    @current_user.decline_request(user)
  end

  def remove
    @current_user.remove_friend(user)
  end
end
