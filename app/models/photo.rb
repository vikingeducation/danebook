class Photo < ActiveRecord::Base

  has_attached_file :photo,
    :styles =>  {
                  :medium => "512x512",
                  :thumb => "150x150#",
                },
    convert_options: { thumbnail: "-gravity center" }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :photo, :less_than => 2.megabytes

  belongs_to :poster, :class_name => 'User'

  has_one :profile_photo_user,
            :foreign_key => :profile_photo_id,
            :class_name => 'User',
            :dependent => :nullify

  has_one :cover_photo_user,
            :foreign_key => :cover_photo_id,
            :class_name => 'User',
            :dependent => :nullify

  has_many :likes, :as => :liked, :dependent => :destroy
  has_many :likers, :through => :likes, :source => :user

  has_many :comments, :as => :commentable, :dependent => :destroy


  attr_accessor :photo_from_url

  def photo_from_url=(url = "")
    self.photo = open(url) unless url.empty?
  end

  def render_date
    self.photo_updated_at.to_date.to_formatted_s(:long_ordinal)
  end

end
