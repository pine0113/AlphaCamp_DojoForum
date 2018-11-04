class AddPostAccessDefault < ActiveRecord::Migration[5.1]
  def change
    change_column_default :posts, :access, "all"
    change_column : :posts, :access, :string
  end
end
