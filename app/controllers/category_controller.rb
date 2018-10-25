class CategoryController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    
    case params["sort"]
    when "view_count_up"
      @posts =  @category.posts.where.not(published_at: [nil, ""]).sort_by_popularity('ASC').page(params[:page]).per(20)
    when "view_count_down"
      @posts =  @category.posts.where.not(published_at: [nil, ""]).sort_by_popularity('DESC').page(params[:page]).per(20)
    when "reply_count_up"
      @posts =  @category.posts.where.not(published_at: [nil, ""]).order("replies_count ASC").page(params[:page]).per(20)
    when "reply_count_down"
      @posts =  @category.posts.where.not(published_at: [nil, ""]).order("replies_count DESC").page(params[:page]).per(20)
    when "reply_time_up"
      @posts =  @category.posts.where.not(published_at: [nil, ""]).order("last_reply_time ASC").page(params[:page]).per(20)
    when "reply_time_down"
      @posts =  @category.posts.where.not(published_at: [nil, ""]).order("last_reply_time DESC").page(params[:page]).per(20)
    else
      @posts = Post.where.not(published_at: [nil, ""]).page(params[:page]).per(20)
    end
    @categories = Category.all


  end
end
