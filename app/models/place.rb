class Place < ApplicationRecord
  has_many :favorites
  has_many :comments
  has_many :place_users
  has_many :users, through: :place_users
  has_many :group_places
  has_many :groups, through: :group_places
  has_many :images

  validates_uniqueness_of :google_id

  #https://github.com/alexreisner/geocoder
  reverse_geocoded_by :lat, :lng

  def self.get_nearby(lat,lng,distance)
    Place.near([lat,lng], distance)
  end
end
