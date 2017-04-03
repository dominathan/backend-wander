class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :show, :destroy, :create]

  def index
    @users = User.all
    render json: {status: 200, message: "YAY"}
  end

  def show
    render json: @user
  end

  def create
    @user = User.find_or_initialize_by(email: user_params[:email])
    if !@user.persisted?
      @user.update_attributes(user_params)
      render json: { user: @user, first_time: true, status: 201 }
    else
      render json: { user: @user, first_time: false, status: 201 }
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def search
    @users = User.find_friends(params[:name])
    render json: @users.results, status: 200
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :birthday, :photo_url, :email, :gender, :facebook_id, :refresh_token, :access_token, :id_token)
    end
end
