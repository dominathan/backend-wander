class Group < ApplicationRecord
  include PgSearch

  validates_uniqueness_of :name

  has_many :group_users
  has_many :users, through: :group_users
  has_many :group_places
  has_many :places, through: :group_places

  pg_search_scope :find_groups, against: [:name]

  def owner
    User.find(owner_id) rescue nil
  end

end
