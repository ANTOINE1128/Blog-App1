class Post < ApplicationRecord
  after_save :update_posts_counter
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def recent_comments(limit = 5)
    comments.order(created_at: :desc).limit(limit)
  end

  private

  def update_post_counter
    author.increment!(:posts_counter)
  end
end
