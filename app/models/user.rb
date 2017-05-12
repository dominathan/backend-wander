class User < ApplicationRecord
  include PgSearch

  validates_uniqueness_of :email

  has_friendship # https://github.com/sungwoncho/has_friendship

  pg_search_scope :find_friends, against: [:first_name, :last_name, :email]

  has_many :comments
  has_many :favorites
  has_many :group_users
  has_many :groups, through: :group_users

  has_many :place_users
  has_many :places, through: :place_users
  has_many :images

end
