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
  scope :types, -> (type) { joins(:types).where(type.split().map { |x| "types.name = '#{x}' OR"}.join(" ")[0..-4])}
  pg_search_scope :find_by_city_or_country, against: [:city, :country]


  def self.set_city_and_country
    Place.all.each do |place|
       country_test = place.data['address_components'].select { |item| item['types'].include?("country") }
       city_test = place.data['address_components'].select { |item| item['types'].include?("locality") }
       if country_test.any?
         country = country_test.first['long_name']
         place.update_attribute(:country, country)
       end
       if city_test.any?
         city = city_test.first['long_name']
         place.update_attribute(:city, city)
       end
     end
  end
end
