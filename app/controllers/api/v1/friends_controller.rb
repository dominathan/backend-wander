class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:create]

  def index
    render json: @current_user.friends.order(:last_name), status: 200
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
