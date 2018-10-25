class AddPostPublishAt < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :published_at, :datetime
    remove_column :posts, :status, :datetime
  end
end
