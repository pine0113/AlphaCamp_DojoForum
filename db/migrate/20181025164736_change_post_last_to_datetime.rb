class ChangePostLastToDatetime < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :last_reply_time
    add_column :posts, :last_reply_time, :datetime
  end
end
