class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    
    has_many :likes, :as => :user_chat
end
