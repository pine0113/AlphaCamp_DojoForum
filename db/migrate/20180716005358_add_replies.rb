class AddReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :replies do |t|
      t.string  :content
      t.integer :user_id
      t.timestamps
    end
  end
end
