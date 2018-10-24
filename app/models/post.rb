class Post < ApplicationRecord
  has_many :replies
  mount_uploader :image, ImageUploader
  belongs_to :user

  has_and_belongs_to_many :categories
  has_many :replies
end
