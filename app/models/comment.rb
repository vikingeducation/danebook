class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :commentable, polymorphic: true, touch: true

  validates :user, :commentable, presence: true
  validates :body, presence: true, length: { minimum: 2 }

  has_many :likes, as: :likable, dependent: :destroy
  has_many :user_likes, through: :likes, source: :user, dependent: :destroy 


  private

  def self.send_comment_notification(id)
    comment = Comment.find(id)
    UserMailer.comment_notification(comment).deliver!
  end

end
