class Post < ApplicationRecord
  
  acts_as_punchable
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :categories
  has_many :replies
  belongs_to :user, counter_cache: true

  def last_reply
    replies.order('id DESC').first
  end

  def status
    if published_at.nil?
      'draft'
    else
      'publish'
    end
  end

  def published?
    published_at?
  end
end
