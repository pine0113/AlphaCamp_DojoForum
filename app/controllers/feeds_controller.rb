class FeedsController < ApplicationController

  def index
    @users_count        = User.count
    @posts_count        = Post.count
    @reply_count        = Reply.count
    @most_popular_posts  = Post.order("replies_count DESC").limit(10)
    @most_noisy_users    = User.order("replies_count DESC").limit(10)
  end
end
