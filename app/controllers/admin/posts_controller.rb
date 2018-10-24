class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.all
    @categories = Category.all
  end
end
