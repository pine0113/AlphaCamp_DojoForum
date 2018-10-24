class AddReplyColumnPostId < ActiveRecord::Migration[5.1]
  def change
    add_column :replies, :post_id, :integer
  end
end
