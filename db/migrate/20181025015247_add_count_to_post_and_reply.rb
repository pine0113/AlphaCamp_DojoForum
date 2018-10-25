class AddCountToPostAndReply < ActiveRecord::Migration[5.1]
  def change
    Post.pluck(:id).each do |i|          # 只從 Restaurant 取出 id 來進行循環計算
      Post.reset_counters(i, :replies) # 重新計算該 Restaurant 的 favorites 次數
    end

    add_column :users, :replies_count, :integer, default: 0 # 慣例命名為 {table_name}_count
    User.pluck(:id).each do |i|          # 只從 Restaurant 取出 id 來進行循環計算
      User.reset_counters(i, :replies) # 重新計算該 Restaurant 的 favorites 次數
    end

    add_column :users, :posts_count, :integer, default: 0 # 慣例命名為 {table_name}_count
    User.pluck(:id).each do |i|          # 只從 Restaurant 取出 id 來進行循環計算
      User.reset_counters(i, :posts) # 重新計算該 Restaurant 的 favorites 次數
    end

  end
end