class Api::V1::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_requests = User.find_by_sql("SELECT users.*, group_users.group_id FROM users INNER JOIN group_users ON group_users.user_id = users.id INNER JOIN groups ON groups.id = group_users.group_id  WHERE users.id = #{@current_user.id} AND groups.private = #{true} AND group_users.pending = #{true}")
    render json: { status: 200, users: @user_requests }
  end
end
