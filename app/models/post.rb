class Post < ApplicationRecord
  default_scope -> { order('id DESC') }
  
  acts_as_punchable
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :categories
  has_many :replies
  belongs_to :user, counter_cache: true

  def last_reply
    replies.order('id DESC').first
  end

  def self.draft
    where(:status => 'draft')
  end

  def self.publish
    where(:status => 'publish')
  end

end
