class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token
  mount_uploader :avatar, AvatarUploader

  has_many :replies
  has_many :posts


  has_many :replied_posts, through: :replies, source: :post

  has_many :collects, :foreign_key => "post_id"
  has_many :collects_posts, through: :collects, source: :post

  has_many :wait_accept_friendships,-> { Friendship.wait_accept }, class_name: "Friendship"
  has_many :wait_accept_friends, through: :wait_accept_friendships, source: :friend

  has_many :inverse_wait_accept_friendships,-> { Friendship.wait_accept }, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friend_askers, through: :inverse_wait_accept_friendships, source: :user

  has_many :friendships,-> { Friendship.accepted }, class_name: "Friendship"
  has_many :friends, through: :friendships, source: :friend
  has_many :friends_posts,-> { Post.access_friend }, through: :friends, class_name: "Post", source: :posts

  def admin?
    role == 'admin'
  end

  def join_admin
    if update_attributes(role: 'admin')
      puts 'Success!'
    else
      puts 'Failed to update record. Handle the error.'
    end
  end

  def remove_admin
    if update_attributes(role: 'user')
      puts 'Success!'
    else
      puts 'Failed to update record. Handle the error.'
    end
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def is_friend(user)
    friends.include?(user) || user.friends.include?(self) 
  end

  def is_wait_accept(user)
    wait_accept_friends.include?(user)
  end

  def is_been_ask_friend(user)
    friend_askers.include?(user)
    
  end

end
