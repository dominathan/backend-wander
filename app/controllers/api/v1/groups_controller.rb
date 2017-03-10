class Api::V1::GroupsController < ApplicationController
  before_action :authenticate_user!

  def my_groups
  end

  def public_groups
  end

  def private_groups
  end

  def create
    group = Group.new(name: params['groupName'], owner_id: @current_user.id, private: params['private'])
    group.save
    if !group.errors.messages.empty?
      render json: { status: 409, errors: group.errors.messages }
      return
    end
    friend_ids =  params['friends'].map { |friend| friend['id'] }
    group.users.push(User.where(id: friend_ids))
    render json: { status: 201 }
  rescue => e
    render json: { status: 409, errors: e }
  end

end
