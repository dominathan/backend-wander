class Place < ApplicationRecord
  include PgSearch

  has_many :favorites
  has_many :comments
  has_many :place_users
  has_many :users, through: :place_users
  has_many :group_places
  has_many :groups, through: :group_places
  has_many :images

  has_many :place_types
  has_many :types, through: :place_types

  validates_uniqueness_of :google_id

  #https://github.com/alexreisner/geocoder
  reverse_geocoded_by :lat, :lng

  scope :nearby, -> (lat, lng, distance = 20) {  Place.near([lat,lng], distance) }
  scope :types, -> (type1,type2,type3,type4,type5) { joins(:types).where('types.name = ? OR types.name = ? OR types.name = ? OR types.name = ? OR types.name = ?', type1,type2,type3,type4,type5) }
  pg_search_scope :find_by_city_or_country, against: [:city, :country]
end
