class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_requests = User.find_by_sql("SELECT users.*, group_users.group_id FROM users INNER JOIN group_users ON group_users.user_id = users.id INNER JOIN groups ON groups.id = group_users.group_id  WHERE users.id = #{@current_user.id} AND groups.private = #{true} AND group_users.pending = #{true}")
    render json: { users: @user_requests }, status: 201
  end

  def likes_index
    @likes = Like.where(user_id: @current_user.id).order('updated_at DESC')
    @likes = @likes.map { |like| { user: User.find(like.friend_id), place: Place.find(like.place_id) } }
    render json: { notifications: @likes}
  end

  def create_like
    @like = Like.create!(user_id: params[:likee], friend_id: @current_user.id, place_id: params[:place_id])
    render json: { like: @like }, status: 201
  end

  def been_there
    @place = Place.find(params[:place_id])
    @current_user.places.push(@place) if !@current_user.places.include?(@place)
    render json: { }, status: 201
  end
end
