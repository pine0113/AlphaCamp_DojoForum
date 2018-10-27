class AddFriendshipAcceptColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :friendships, :accept, :boolean
  end
end
