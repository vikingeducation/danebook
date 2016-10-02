class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :user_id
  belongs_to :post

  has_many :likes, as: :likable, dependent: :destroy

  def commented_on
    self.created_at.strftime("Said on %A, %b %d %Y")
  end
end
