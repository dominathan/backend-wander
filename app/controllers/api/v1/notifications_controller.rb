class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_requests = User.joins(:groups).where(groups: {private: true, owner_id: @current_user.id}).where(group_users: { pending: true })
    render json: { status: 200, users: @user_requests }
  end
end
