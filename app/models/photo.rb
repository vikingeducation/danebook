require 'open-uri'

class Photo < ActiveRecord::Base

  # ASSOCIATIONS
  belongs_to :user

  has_many :likes, as: :likable, dependent: :destroy
  has_many :users_who_liked, through: :likes, source: :user

  has_many :comments, as: :commentable
  has_many :users_who_commented, through: :comments, source: :user



  # Paperclip validations, many built-in
  has_one :profile_photo_user, foreign_key: :profile_photo_id, :class_name => "User"
  has_one :cover_photo_user, foreign_key: :cover_photo_id, :class_name => "User"

  validates_presence_of :user, :image_file_name, :image_content_type, :image_file_size, :image_updated_at

  has_attached_file :image, :styles => { :large => "500x500#", :thumb => "262x262#" }

  validates_attachment_content_type :image, :content_type => [ "image/jpeg",
                                                               "image/gif",
                                                               "image/png" ]
  validates_with AttachmentSizeValidator, :attributes => :image, :less_than => 2.megabytes

  attr_accessor :url


  #returns the actual image by grabbing it from the URL on the object
  def image_from_url(url)
    self.image = open(url)
  end
end
