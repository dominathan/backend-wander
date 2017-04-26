class Place < ApplicationRecord
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
  searchkick #https://github.com/ankane/searchkick

  scope :nearby, -> (lat, lng, distance) {  Place.near([lat,lng], distance) }
  scope :types, -> (type) { joins(:types).where('types.name = ?', type) }

  def self.find_by_city_or_country(query)
    results = Place.search(query, fields: [:city, :country], limit: 100, operator: 'or')
    return results
  end

end
