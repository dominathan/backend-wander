class User < ApplicationRecord
  validates_uniqueness_of :email

  has_friendship # https://github.com/sungwoncho/has_friendship
  searchkick #https://github.com/ankane/searchkick

  has_many :comments
  has_many :favorites
  has_many :group_users

  def self.find_friends(query)
    results = User.search(query, fields: [:first_name, :last_name], limit: 10, operator: 'or')
    return results
  end

end
