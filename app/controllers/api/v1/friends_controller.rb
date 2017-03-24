class Api::V1::FriendsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only: [:create,:accept,:decline,:remove]

  def index
    render json: @current_user.friends.order(:last_name), status: 200
  end

  def create
    @current_user.friend_request(@user)
    render json: { status: 201 }
  end

  def requested_friends
    render json: @current_user.requested_friends
  end

  def pending_friends
    render json: @current_user.pending_friends
  end

  def accept
    if @current_user.accept_request(@user)
      render json: { status: 201 }
    else
      render json: { status: 404 }
    end
  end

  def decline
    @current_user.decline_request(@user)
    render json: { status: 201 }
  end

  def remove
    @current_user.remove_friend(@user)
  end

  private
    def get_user
      @user = User.find(params[:id])
    end
end
