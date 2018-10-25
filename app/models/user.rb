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


  has_many :friendships, :foreign_key => "friend_id"
  has_many :friends, through: :friendships, source: :user

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

end
