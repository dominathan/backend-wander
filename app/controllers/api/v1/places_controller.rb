class Api::V1::PlacesController < ApplicationController
  # before_action :authenticate_user!

  def index
  end

  def create
    byebug

    @place = Place.new(place_params)

    if @place.save
      render json: @user, status: 201
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def place_params
      params.require(:place).permit(:name, :lat, :lng, :google_id, :google_place_id)
    end

end
