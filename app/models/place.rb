class Place < ApplicationRecord
  validates_uniqueness_of :google_id
  has_many :favorites
  has_many :comments

  has_many :group_places
  has_many :groups, through: :group_places

end
