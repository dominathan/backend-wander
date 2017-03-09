class GroupsController < ApplicationController
  before_action :authenticate_user!

  def my_groups
  end

  def public_groups
  end

  def private_groups
  end

end
