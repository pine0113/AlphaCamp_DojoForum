class Reply < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :post, counter_cache: true
  paginates_per 20

  def self.find_by_post_page(post_id, current_page)
    return false if post_id.nil?
    if current_page == nil
      current_page = 1
    end
    where("post_id = #{post_id}").order('id ASC').page(current_page)
  end
end
