class Post < ApplicationRecord
  
  acts_as_punchable
  mount_uploader :image, ImageUploader
  has_and_belongs_to_many :categories
  has_many :replies
  belongs_to :user, counter_cache: true
  scope :access_all, -> { where(:access => "all") }
  scope :access_friend, -> { where(:access => "friend") }
  scope :access_me, -> { where(:access => "self") }
  scope :published, -> { where.not(published_at: [nil, ""]) }

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

  def self.can_view_by(user)
    sql1 = user.posts.published.to_sql 
    sql2 = Post.access_all.published.to_sql
    sql3 = user.friends_posts.published.to_sql
    Post.from("( #{ sql1 } UNION #{ sql2 } UNION #{sql3}) AS posts")
  end


end