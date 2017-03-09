class Group < ApplicationRecord
  #has_and_belongs_to_many users -- make GroupUser
  #has_and_belongs_to_many places -- make GroupPlace
  validates_uniqueness_of :name

  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_places
  has_many :places, through: :group_places
end
