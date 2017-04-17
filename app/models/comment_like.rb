class CommentLike < ApplicationRecord
  belongs_to :user
  belongs_to :comment, counter_cache: true

  validates_uniqueness_of :user_id, scope: :comment_id
end
