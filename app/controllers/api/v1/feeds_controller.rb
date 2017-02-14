class Api::V1::FeedsController < ApplicationController
  before_action :authenticate_user!

  def index
    @commnets = Comment.includes(:user, :place).order('created_at DESC').limit(10)
                      .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
    render json: @commnets, status: 200
  end
end
