class Place < ApplicationRecord
  validates_uniqueness_of :google_id

end
