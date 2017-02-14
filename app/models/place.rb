class Place < ApplicationRecord
  validates_uniqueness_of :google_id
  has_many :favorites
  has_many :comments

end
