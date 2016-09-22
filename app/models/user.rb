class User < ApplicationRecord
  has_many :posts
  has_one :profile, dependent: :nullify
  has_many :photos
  has_many :likes
  has_many :friended_relationships,  class_name:  "Relationship",
                                   foreign_key: "friender_id",
                                   dependent:   :destroy
  has_many :been_friended_relationships, class_name:  "Relationship",
                                   foreign_key: "friended_id",
                                   dependent:   :destroy
  has_many :friends, through: :friended_relationships,  source: :friended
  has_many :been_friended, through: :been_friended_relationships, source: :friender

  before_create :generate_token
  after_create :create_profile
  #after_create :welcome_email
  has_secure_password

  validates :password, 
            :length => { :in => 5..20 }, 
            :allow_nil => true 
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
          
  accepts_nested_attributes_for :profile

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def all_posts
    self.posts.all.order('created_at DESC')
  end

  def self.search(name)
    name.split(" ").map do |n|
      @users = [User.where('first_name ILIKE ?', "#{n}%")]
      @users << User.where('last_name ILIKE ?', "#{n}%")
    end.flatten.uniq
  end

  def welcome_email
    UserMailer.welcome(self).deliver!
  end

  def name
    self.first_name + " " + self.last_name
  end

end
