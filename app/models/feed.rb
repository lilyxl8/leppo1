require 'rest_client'
require 'instagram'

class Feed < ActiveRecord::Base
  ACCESS_TOKEN = "38734087.5421169.569836061a4d4a2eab59d74def5621aa"

  validates :ig_user, presence: true, uniqueness: true
  validates :country_id, presence: true
  validates :category_id, presence: true
  # validates :access_token, presence: true

  belongs_to :category
  belongs_to :country
  has_many :posts


  def get_posts
    client = Instagram.client(:access_token => ACCESS_TOKEN)
    user = JSON.parse(client.user_search(self.ig_user).to_json)[0]
    feed = JSON.parse(client.user_recent_media(user["id"]).to_json,
                      { count: 10 })

    feed.each do |post|
      posttime << post["caption"]["created_time"]
      new_post = Post.new({
        feed_id: self.id,
        created_time: post["caption"]["created_time"],
        caption: post["caption"]["text"],
        thumb_img: post["images"]["low_resolution"]["url"],
        full_img: post["images"]["standard_resolution"]["url"] })
      new_post.save
    end

  end
end
