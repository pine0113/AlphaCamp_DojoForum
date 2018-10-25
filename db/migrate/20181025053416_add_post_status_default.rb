class AddPostStatusDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :posts, :status, "publish"
  end
end
