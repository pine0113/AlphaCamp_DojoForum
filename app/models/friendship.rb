class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :wait_accept, -> { where(:accept => false) }
  scope :accepted, -> { where(:accept => true) }

end
