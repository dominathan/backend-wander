class Api::V1::PlacesController < ApplicationController
  before_action :authenticate_user!

  def index
    @places = Place.all
    render json: @places, status: 200
  end

  def create
    @place = Place.find_or_initialize_by(google_id: place_params[:google_id])
    if !@place.persisted?
      @place.update_attributes(place_params)
    end
    comment = @place.comments.build(user_id: current_user.id, text: params[:comment])
    comment.save
    Favorite.create(user_id: current_user.id, place_id: @place.id) if params[:favorite]
    render json: @place, status: 201
  end

  private
    def place_params
      params.require(:place).permit(:name, :lat, :lng, :google_id, :google_place_id)
    end

end
