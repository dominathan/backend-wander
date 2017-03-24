class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!

  def my_groups
    @groups = @current_user.groups
    render json: @groups, status: 201
  end

  def public_groups
    @groups = Group.where(private: false).limit(10)
    render json: @groups, status: 201
  end

  def private_groups
    @groups = Group.where(private: true).limit(10)
    render json: @groups, status: 201
  end

  def create
    group = Group.new(name: params['groupName'], owner_id: @current_user.id, private: params['private'])
    group.save
    if !group.errors.messages.empty?
      render json: { status: 409, errors: group.errors.messages }
      return
    end
    friend_ids =  params['friends'].map { |friend| friend['id'] }.push(@current_user.id)
    group.users.push(User.where(id: friend_ids))
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

  def search
    @groups = Group.find_groups(params[:search])
    render json: @groups.results, status: 200
  end

  def join_private_group

  end

end
