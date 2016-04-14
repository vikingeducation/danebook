require 'open-uri'

class Photo < ActiveRecord::Base

  has_attached_file :image,
                    styles: { large: "700x700", 
                              medium: "300x300#", 
                              thumb: "100x100#" }

  # TODO: make validation work 
  validates_attachment_content_type :image,
                                    presence: { message: "Please select a photo" },
                                    content_type: /\Aimage\/.*\Z/


  attr_accessor :delete_image

  before_validation { image.clear if delete_image == '1' }


  belongs_to :user, counter_cache: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  has_one :profile


  def image_from_url(url)
    self.image = open(url) unless url.empty?
  end


end
