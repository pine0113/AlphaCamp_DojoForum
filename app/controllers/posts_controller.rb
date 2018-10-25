class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_post, except: [:index, :new, :create]

  def index
    case params["sort"]
    when "view_count_up"
      @posts = Post.where("status != ?", 'draft').sort_by_popularity('ASC').page(params[:page]).per(20)
    when "view_count_down"
      @posts = Post.where("status != ?", 'draft').sort_by_popularity('DESC').page(params[:page]).per(20)
    when "reply_count_up"
      @posts = Post.where("status != ?", 'draft').order("replies_count ASC").page(params[:page]).per(20)
    when "reply_count_down"
      @posts = Post.where("status != ?", 'draft').order("replies_count DESC").page(params[:page]).per(20)
    when "reply_time_up"
      @posts = Post.where("status != ?", 'draft').order("last_reply_time ASC").page(params[:page]).per(20)
    when "reply_time_down"
      @posts = Post.where("status != ?", 'draft').order("last_reply_time DESC").page(params[:page]).per(20)
    else
      @posts = Post.where("status != ?", 'draft').page(params[:page]).per(20)
    end
    @categories = Category.all

    #Post 
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def show
    @post.punch(request)
    @reply = Reply.new
    @replies = Reply.find_by_post_page(@post.id,params[:page])
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = '文章新增完成'
      redirect_to post_path(@post)
    else
      flash[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def save_as_draft
  end

  def update
    if ((@post.user =! current_user) && (current_user.role != "admin"))
      session[:return_to] ||= request.referer
      redirect_to session[:return_to]
      flash[:alert] = "you can not edit this post"
    else
      if @post.update(post_params)
        flash[:notice] = '文章已更新'
        redirect_to @post
      else
        flash[:alert] = @post.errors.full_messages.to_sentence
        render :edit
      end
    end
  end

  def destroy
    if ((@post.user != current_user) && (current_user.role != "admin"))
      session[:return_to] ||= request.referer
      redirect_to session[:return_to]
      flash[:alert] = "you can not delete this post"
    else
      @post.destroy
      redirect_to posts_path
      flash[:alert] = "post was deleted"
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :view_count,
                                 :replies_count, :user_id,
                                 :created_at, :updated_at, 
                                 :access, :image,:category_ids => [])
  end

end
