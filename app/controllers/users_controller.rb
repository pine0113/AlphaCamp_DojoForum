class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def edit
    if @user != current_user
      flash[:alert] = 'Not allow!'
      redirect_to @user
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = 'user已更新'
      redirect_to @user
    else
      flash[:alert] = @user.errors.full_messages.to_sentence
      render :edit
    end
  end

  def show
    @posts = @user.posts.where.not(published_at: [nil, ""]).order('id DESC')
  end

  def comments
    @replies = @user.replies;
  end

  def friends
    @wait_accept_friends = @user.wait_accept_friends;
    @friend_askers = @user.friend_askers;
    @friends = @user.friends;
  end

  def drafts
    @posts = @user.posts.where(published_at: [nil, ""]).order('id DESC')
  end

  def collects
    @collects_posts = @user.collects_posts
  end


  private

  def set_user
    @user = User.find(params[:id])
    @posts = @user.posts
    @replied_posts = @user.replied_posts
  end

  def user_params
    params.require(:user).permit(:intro,:avatar)
  end

end
