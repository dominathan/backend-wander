class Api::V1::FeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    # lat, lng, distance = params[:lat], params[:lng], params[:distance]
    # place = Place.nearby(lat,lng,distance)
    # place_ids = place.map { |place| place.id }
    @comments = Comment.includes(:user, :place).order('created_at DESC').limit(100)
                      .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
                      # .select { |obj| place_ids.include?(obj[:place].id) }
    render json: @comments, status: 200
  end

  # alias as feed_by_following
  def feed_by_friends
    @comments = Comment.includes(:user, :place)
       .where(user_id: (@current_user.friends.map(&:id) + @current_user.pending_friends.map(&:id)).uniq)
       .order('created_at DESC').limit(100)
       .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
    render json: @comments, status: 200
  end

  def feed_by_experts
    experts = User.where(expert: true).map(&:id)
    @comments = Comment.includes(:user, :place)
       .where(user_id: experts)
       .order('created_at DESC').limit(100)
       .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
    render json: @comments, status: 200
  end

  def feed_by_user
    if !params[:user_id]
      comments = Comment.where(user_id: @current_user.id)
    else
      comments = Comment.where(user_id: User.find(params[:user_id]))
    end
    @comments = comments.order('created_at DESC').limit(100)
                        .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
    render json: @comments, status: 200
  end

end
