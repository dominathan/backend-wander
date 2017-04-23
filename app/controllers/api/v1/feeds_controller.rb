class Api::V1::FeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.includes(:user, :place).order('created_at DESC').limit(100)
                      .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
    render json: @comments, status: 200
  end

  def feed_by_friends
    @comments = Comment.includes(:user, :place)
       .where(user_id: @current_user.friends.map(&:id))
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
      @comments = Comment.where(user_id: @current_user.id)
    else
      @comments = Comment.where(user_id: User.find(params[:user_id]))
    end

    @comments.order('created_at DESC').limit(100)
             .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
    render json: @comments, status: 200
  end

end
