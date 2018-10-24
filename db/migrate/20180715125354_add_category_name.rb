class AddCategoryName < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :name, :text
  end
end
