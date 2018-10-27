class CategoryController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    if current_user
    
      case params["sort"]
      when "view_count_up"
        @posts =  @category.posts.can_view_by(current_user).sort_by_popularity('ASC').page(params[:page]).per(20)
      when "view_count_down"
        @posts =  @category.posts.can_view_by(current_user).sort_by_popularity('DESC').page(params[:page]).per(20)
      when "reply_count_up"
        @posts =  @category.posts.can_view_by(current_user).order("replies_count ASC").page(params[:page]).per(20)
      when "reply_count_down"
        @posts =  @category.posts.can_view_by(current_user).order("replies_count DESC").page(params[:page]).per(20)
      when "reply_time_up"
        @posts =  @category.posts.can_view_by(current_user).order("last_reply_time ASC").page(params[:page]).per(20)
      when "reply_time_down"
        @posts =  @category.posts.can_view_by(current_user).order("last_reply_time DESC").page(params[:page]).per(20)
      else
        @posts = @category.posts.can_view_by(current_user).page(params[:page]).per(20)
      end
    else
      case params["sort"]
      when "view_count_up"
        @posts =  @category.posts.access_all.published.sort_by_popularity('ASC').page(params[:page]).per(20)
      when "view_count_down"
        @posts =  @category.posts.access_all.published.sort_by_popularity('DESC').page(params[:page]).per(20)
      when "reply_count_up"
        @posts =  @category.posts.access_all.published.order("replies_count ASC").page(params[:page]).per(20)
      when "reply_count_down"
        @posts =  @category.posts.access_all.published.order("replies_count DESC").page(params[:page]).per(20)
      when "reply_time_up"
        @posts =  @category.posts.access_all.published.order("last_reply_time ASC").page(params[:page]).per(20)
      when "reply_time_down"
        @posts =  @category.posts.access_all.published.order("last_reply_time DESC").page(params[:page]).per(20)
      else
        @posts = @category.posts.access_all.published.page(params[:page]).per(20)
      end

    end
    @categories = Category.all


  end
end
