class User < ActiveRecord::Base
  has_one :profile, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendings, dependent: :destroy

  has_one :avatar, class_name: Photo
  has_many :friends, through: :friendings 



  validates :password_confirmation,  :presence => true
  validates :password,  :presence => true,
                        :length => {:in => 4..34},
                        :allow_nil => true

  validates :email,     :presence => true,
                        :format => /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                        :uniqueness => true,
                        :length => {:in => 4..54}
  
  has_secure_password
  after_create :create_profile
  #after_create :send_delayed_email

  def full_name
      self.first_name + " " + self.last_name
  end

  def likes?(thing)
    Like.where(user: self, liking_id: thing.id, liking_type: thing.class).any?
  end

  def self.search(word)
    User.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{word}%", "%#{word}%")
  end

  def self.create_profile
    Profile.new(user_id: self.id)
  end

  private

  def send_delayed_email
    User.delay.send_welcome_email(self.id)
  end

  def self.send_welcome_email(id)
    user = User.find(id)
    UserMailer.welcome(user).deliver
  end

end
