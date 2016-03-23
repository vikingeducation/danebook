require 'open-uri'

class Image < ActiveRecord::Base

  belongs_to :user

  has_many   :comments, -> { order('created_at ASC') }, as: :commentable, dependent:   :destroy
  has_many   :likes,    as: :likeable,    dependent:   :destroy
  has_many   :liked_by_users, through: :likes, source: :liked_by

  #has_one :image_profile, class_name: "User", foreign_key: :image_id
  #has_one :cover_profile, class_name: "User", foreign_key: :cover_id
  
  has_attached_file :picture, 
               :styles => { :medium => "300x300", :thumb => "100x100" }

  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  attr_accessor :image_url

  def image_from_url(url)
    #url =~ /\A#{URI::regexp}\z/
    self.picture = open(url)
  end

  def liked_by_user(user)
    like = self.likes.where("user_id = ?",user.id)
  end 

  def liked_by_other_users(liked_by_user)
    likes = self.liked_by_users.where("user_id != ?", liked_by_user)
  end

end