class Posting < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :user
end
