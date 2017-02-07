class Api::V1::PlacesController < ApplicationController
  before_action :authenticate_user!

  def index
    place_ids = Favorite.where(user_id: User.all).map(&:place_id)
    @places = Place.where(id: place_ids)
    render json: @places, status: 200
  end

  def create
    @place = Place.find_or_initialize_by(google_id: place_params[:google_id])
    if !@place.persisted?
      @place.update_attributes(place_params)
    end
    Favorite.create(user_id: User.find_by(email: params[:user][:email]).id, place_id: @place.id)
    render json: @place, status: 201
  end

  private
    def place_params
      params.require(:place).permit(:name, :lat, :lng, :google_id, :google_place_id)
    end

end
