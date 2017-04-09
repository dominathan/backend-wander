class Type < ApplicationRecord
  has_many :place_types
  has_many :places, through: :place_types

  validates_uniqueness_of :name

end
