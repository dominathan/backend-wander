class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:create]

  def index
    render json: @current_user.friends + @current_user.requested_friends, status: 200
  end

  def create
    if !@current_user.friend_request(@user)
      @current_user.accept_request(@user)
    end
    render json: { user: @user }, status: 201
  end

  def requested_friends
    #followers
    render json: @current_user.requested_friends + @current_user.friends
  end

  def pending_friends
    #followees
    render json: @current_user.pending_friends + @current_user.friends
  end

  def requested_friends_of_user
    user = User.find(params['user_id'])
    if user
      render json: user.requested_friends + user.friends, status: 200
    else
      render json: {}, status: 404
    end
  end

  # def accept
  #   if @current_user.accept_request(@user)
  #     render json: { user: @user }, status: 201
  #   else
  #     render json: { user: @user }, status: 404
  #   end
  # end

  # def decline
  #   @current_user.decline_request(@user)
  #   render json: { user: @user }, status: 409
  # end

  # def remove
  #   @current_user.remove_friend(@user)
  # end

  private
    def get_user
      @user = User.find(params[:id])
    end
end
