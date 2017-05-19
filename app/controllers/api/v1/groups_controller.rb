class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!

  def group_places
    group_and_places = Group.includes(:users, :places).find_by(name: params['groupName'])
    if group_and_places
      group_users = group_and_places.users
      group_places = group_and_places.places
      group_feed = Comment.where(place_id: group_places)
                          .map { |comment| {comment: comment.text, created_at: comment.created_at, user: comment.user, place: comment.place } }
      render json: { status: 200, places: group_places, feed: group_feed, users: group_users }
    else
      render json: { status: 404 }
    end
  end

  def create
    group_to_create = Group.new(name: params['groupName'], owner_id: @current_user.id, private: params['private'], lat: params['lat'], lng: params['lng'], city: params['city'])
    group_to_create.save
    if !group_to_create.errors.messages.empty?
      render json: { status: 409, errors: group_to_create.errors.messages }
      return
    end
    friend_ids =  params['friends'].map { |friend| friend['id'] }.push(@current_user.id)
    group_to_create.users.push(User.where(id: friend_ids))
    render json: { status: 201 }
  rescue => e
    render json: { status: 409, errors: e }
  end

  def join_public_group
    group_to_join = Group.find_by(name: params['name'])
    if group_to_join.users.push(@current_user)
      render json: { status: 201 }
    else
      render json: { status: 401 }
    end
  end

  def request_join_private_group
    group_to_join = Group.find_by(name: params['name'])
    if group_to_join.group_users.create(user_id: @current_user.id, pending: true, accepted: false)
      render json: { status: 201, message: "Request to join sent." }
    else
      render json: { status: 404, message: "Request failed" }
    end
  end

  def accept_join_private_group
    group_to_accept_user = Group.find_by(id: params[:group_id])
    if group_to_accept_user.group_users.where(user_id: params[:user_id]).update_all({ pending: false, accepted: true })
      render json: { status: 201, message: "Accepted." }
    else
      render json: { status: 404, message: "Failed to join #{group_to_accept_user.name}."}
    end
  end

  def my_groups
    @groups = @current_user.groups.map { |x| { group: x, users: x.users } }
    render json: @groups, status: 201
  end

  def public_groups
    @groups = Group.where(private: false)
                   .limit(50)
                   .map { |group_name| { group: group_name, users: group_name.users } }
                   .reject { |group_name| group_name[:users].map { |user| user.id }.include?(@current_user.id) }

    render json: @groups, status: 201
  end

  def private_groups
    @groups = Group.where(private: true)
                   .limit(50)
                   .map { |group_name| { group: group_name, users: group_name.users } }
                   .reject { |group_name| group_name[:users].map { |user| user.id }.include?(@current_user.id) }
    render json: @groups, status: 201
  end

  def add_friends
    @group = Group.find(params[:group_id])
    friends_ids = params[:friends].map { |friend| friend['id'] }
    users = User.find(friends_ids)
    if @group
      @group.users.push(users)
      render json: { status: 201 }
    else
      render json: { status: 404 }
    end
  end

  def search
    @groups = Group.find_groups(params[:search])
    @groups = @groups.reject { |group| group.group_users.map { |gu| gu.user_id }.include?(@current_user.id) }
    render json: @groups, status: 200
  end

end
