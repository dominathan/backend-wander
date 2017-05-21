class Api::V1::FeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:lat] && params[:lng]
      lat, lng, distance = params[:lat], params[:lng], params[:distance]
      places = Place.nearby(lat,lng,distance)
      place_ids = places.map { |place| place.id }
      @comments = Comment.includes(:user, :place).where(place_id: place_ids).order('created_at DESC').limit(100)
    else
      @comments = Comment.includes(:user, :place).order('created_at DESC').limit(100)
    end
    likes = Like.where(friend_id: @current_user.id).map(&:place_id)
    user_places = @current_user.places.map(&:id)
    @comments = @comments.map do |comment|
      {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place, showHeart: likes.include?(comment.place.id), showBeenThere: user_places.include?(comment.place.id) }
    end
                      # .select { |obj| place_ids.include?(obj[:place].id) }?
    render json: @comments, status: 200
  end

  # alias as feed_by_following
  def feed_by_friends
    likes = Like.where(friend_id: @current_user.id).map(&:place_id)
    user_places = @current_user.places.map(&:id)
    @comments = Comment.includes(:user, :place)
       .where(user_id: (@current_user.friends.map(&:id) + @current_user.pending_friends.map(&:id)).uniq)
       .order('created_at DESC').limit(100)
    @comments = @comments.map do |comment|
      {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place, showHeart: likes.include?(comment.place.id), showBeenThere: user_places.include?(comment.place.id) }
    end
    render json: @comments, status: 200
  end

  def feed_by_experts
    likes = Like.where(friend_id: @current_user.id).map(&:place_id)
    user_places = @current_user.places.map(&:id)
    experts = User.where(expert: true).map(&:id)
    @comments = Comment.includes(:user, :place)
       .where(user_id: experts)
       .order('created_at DESC').limit(100)
    @comments = @comments.map do |comment|
      {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place, showHeart: likes.include?(comment.place.id), showBeenThere: user_places.include?(comment.place.id) }
    end
    render json: @comments, status: 200
  end

    def feed_by_user
    likes = Like.where(friend_id: @current_user.id).map(&:place_id)
    user_places = @current_user.places.map(&:id)
    if !params[:user_id]
      comments = Comment.where(user_id: @current_user.id)
    else
      comments = Comment.where(user_id: User.find(params[:user_id]))
    end
    @comments = comments.order('created_at DESC').limit(100)
    @comments = @comments.map do |comment|
      {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place, showHeart: likes.include?(comment.place.id), showBeenThere: user_places.include?(comment.place.id) }
    end
    render json: @comments, status: 200
  end

end
