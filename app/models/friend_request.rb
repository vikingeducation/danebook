class FriendRequest < ActiveRecord::Base

  belongs_to :requester, :class_name => "User", :foreign_key => :requester_id

  belongs_to :requestee, :class_name => "User", :foreign_key => :requestee_id

  validates_presence_of :requester, :requestee

end
