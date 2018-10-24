class CreateJoinTbleCategorisPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_posts do |t|
      t.string :category_id
      t.string :post_id
    end
  end
end
