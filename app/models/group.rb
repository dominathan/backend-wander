class Group < ApplicationRecord
  validates_uniqueness_of :name

  searchkick #https://github.com/ankane/searchkick

  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_places
  has_many :places, through: :group_places

  def self.find_groups(query)
    results = Group.search(query, fields: [:name], limit: 10)
    return results
  end

end
