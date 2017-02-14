class User < ApplicationRecord
  validates_uniqueness_of :email

  has_many :comments
  has_many :favorites
  
end
