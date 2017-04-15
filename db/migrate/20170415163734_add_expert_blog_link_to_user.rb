class AddExpertBlogLinkToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :expert_blog_log, :string
  end
end
