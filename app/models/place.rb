class Place < ApplicationRecord
  validates_uniqueness_of :google_id
  has_many :favorites
  has_many :comments

  has_many :place_users
  has_many :users, through: :place_users

  has_many :group_places
  has_many :groups, through: :group_places

  has_many :images


end
