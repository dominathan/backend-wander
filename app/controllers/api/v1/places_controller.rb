class Api::V1::PlacesController < ApplicationController
  before_action :authenticate_user!

  def index
    @places = Place.all
    render json: @places, status: 200
  end

  def user_places
    user = User.find_by(email: params['email'])
    @user_object = { places: user.places, favorites: user.favorites.joins(:place).select('places.lat as lat, places.lng as lng, places.name as name, favorites.*') }
    render json: @user_object, status: 200
  end

  def favorited_places
    # @places = Place.joins(:favorite).order(;)
  end

  def create
    @place = Place.find_or_initialize_by(google_id: place_params[:google_id])
    if !@place.persisted?
      @place.update_attributes(place_params)
    end
    @current_user.places.push(@place)
    if params[:comment] && params[:comment].length > 0
      comment = @place.comments.build(user_id: current_user.id, text: params[:comment].try(:strip))
      comment.save
    end
    if params[:favorite]
      Favorite.create(user_id: current_user.id, place_id: @place.id) if params[:favorite]
    end
    render json: @place, status: 201
  end

  private
    def place_params
      params.require(:place).permit(:name, :lat, :lng, :google_id, :google_place_id, :city, :country)
    end

end
