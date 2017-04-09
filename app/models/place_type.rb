class PlaceType < ApplicationRecord
  belongs_to :type
  belongs_to :place
end
