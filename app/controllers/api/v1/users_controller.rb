class Api::V1::UsersController < ApplicationController

  def friend
    user = User.find(params['id'])
    if ( current_user.is_friend(user) || current_user.is_wait_accept(user) || current_user.is_been_ask_friend(user)  || user == current_user )
      render :json => { :mes => "already applying or the same_man "}
    else
      @friendship = Friendship.new(:friend_id => params['id'], :user_id => current_user.id , :accept => false)
      @friendship.save
      render :json => { :id => @friendship.friend.id, :name => @friendship.friend.name }
    end
  end

  def unfriend
    @friendship = Friendship.where(:friend_id => params['id'], :user_id => current_user.id ).first 
    @friendship.destroy unless @friendship.nil?
    @friendship = Friendship.where(:user_id => params['id'], :friend_id => current_user.id ).first
    @friendship.destroy unless @friendship.nil?
  end

  def acceptfriend
    @friendships = Friendship.where(:friend_id =>current_user.id , :user_id =>  params['id'])
    @friendships.each do |friendship|
      friendship.accept = true;
      friendship.save
    end
    @re_friendship = Friendship.new(:friend_id =>  params['id'], :user_id =>current_user.id , :accept => true)
    @re_friendship.save

    render :json => { :id => @re_friendship.user.id, :name => @re_friendship.user.name }

  end

  private

  def post_params
    params.permit(:title, :content,:user_id,
                                :access, :image,:category_ids => [])
  end

end
