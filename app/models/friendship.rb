class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  validates :following_id, uniqueness: { scope: :user_id }
  
end
