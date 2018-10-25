class AddPostReplycountDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :posts, :replies_count, 0
  end
end
