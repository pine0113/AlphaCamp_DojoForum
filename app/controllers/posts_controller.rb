class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, except: [:index, :new, :create]

  def index
    @posts = Post.page(params[:page]).per(20)
    @categories = Category.all
  end

  def new
    @post = Post.new
    @categories = Category.all
  end
  
  def show
    @reply = Reply.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:notice] = '文章新增完成'
      redirect_to post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :view_count,
                                 :replies_count, :user_id, :category_id,
                                 :created_at, :updated_at, :access, :image,:category_ids => [])
  end
end
