class Api::V1::PlacesController < ApplicationController

  # MAKE SURE TO VALIDATE IMAGES
  before_action :authenticate_user!, except: [:images]

  def index
    @places = Place.all.includes(:favorites).limit(100).map { |place| place.attributes.merge({favorites_count: place.favorites.count}) }.sort_by { |place| place[:favorites_count] }.reverse!
    render json: @places, status: 200
  end

  def user_places
    user = User.find_by(email: params['email']) || @current_user
    @user_object = { places: user.places, favorites: user.favorites.joins(:place).select('places.lat as lat, places.lng as lng, places.name as name, favorites.*') }
    render json: @user_object, status: 200
  end

  def show
    @place = Place.find(params[:id])
    render json: { feed: @place.comments.map { |x| x.attributes.merge({user: User.find(x.user_id).attributes}) }, place: @place, images: @place.images.map { |img| {uri: img.s3_file_path}}, favorites: @place.favorites.map { |x| x.attributes.merge({user: User.find(x.user_id).attributes}) } }, status: 200
  end

  def favorited_places
    # @places = Place.joins(:favorite).order(;)
  end

  def filter_by_expert
    @places = User.where(expert: true).flat_map { |expert| expert.places }
    render json: @places, status: 200
  end

  def filter_by_friends
    @places = @current_user.friends.flat_map { |friend| friend.places }
    render json: @places, status: 200
  end

  def favorited_user_places
    @user_object = { places: @current_user.places, favorites: @current_user.favorites.joins(:place).select('places.lat as lat, places.lng as lng, places.name as name, favorites.*') }
    render json: @user_object, status: 200
  end

  def create
    @place = Place.find_or_initialize_by(google_id: place_params[:google_id])
    if !@place.persisted?
      @place.update_attributes(place_params.slice(:name, :lat, :lng, :google_id, :google_place_id, :city, :country, :data))

      @place.data['types'].each do |type|
        type_id = Type.find_by(name: type).id
        @place.place_types.create(type_id: type_id)
      end
    end

    @current_user.places.push(@place) if !@current_user.places.include?(@place)

    if params[:comment] && params[:comment].length > 0
      comment = @place.comments.build(user_id: @current_user.id, text: params[:comment].try(:strip))
      comment.save
    end

    Favorite.create(user_id: @current_user.id, place_id: @place.id) if params[:favorite]

    if params[:group]
      group_to_add_place = Group.find_by(id: params[:group][:id])
      group_to_add_place.places.push(@place) if !group_to_add_place.places.include?(@place)
    end
    render json: @place, status: 201
  end

  def images
    img = Image.new(avatar: params['photo'], place_id: Place.find_by(name: params['placename']).id)
    img.save
  end

  def filter_by_types
    lat, lng, distance, type = params[:lat], params[:lng], params[:distance], params[:type]
    @places = Place.nearby(lat,lng,distance).types(type)
    render json: @places, status: 200
  end

  private
    def place_params
      params.require(:place).permit(:name, :lat, :lng, :google_id, :google_place_id, :city, :country, :favorite, :group, :image => [:avatar], data: permit_recursive_params(params[:place][:data]))
    end

    def permit_recursive_params(params)
      (params.try(:to_unsafe_h) || params).map do |key, value|
        if value.is_a?(Array)
          if value.first.respond_to?(:map)
            { key => [ permit_recursive_params(value.first) ] }
          else
            { key => [] }
          end
        elsif value.is_a?(Hash)
          { key => permit_recursive_params(value) }
        else
          key
        end
      end
    end


end
