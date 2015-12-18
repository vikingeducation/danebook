class User < ActiveRecord::Base
  validates :email,    presence: { message: "Must have an email." },
                       uniqueness: true
  validates :password, length:   { in: 6..20 },
                       allow_nil: true


  has_secure_password

  has_many :posts, 
           :dependent => :destroy
  has_many :comments, 
           :dependent => :destroy
  has_many :likes, 
           :dependent => :destroy
  has_one  :profile, 
           :dependent => :destroy

  accepts_nested_attributes_for :profile

  # When acting as the initiator of the friending
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending", 
                                  :dependent => :destroy
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient
                                  
  # When acting as the recipient of the friending
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending", 
                                  :dependent => :destroy
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  has_many :photos,
           :dependent => :destroy

  belongs_to :profile_photo, 
             :class_name => "Photo"
  belongs_to :cover_photo, 
             :class_name => "Photo"

  before_create :generate_token
  after_create :auto_generate_profile

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

  def auto_generate_profile
    unless profile
      create_profile
    end
  end

  def self.search_user_by(keyword)
    if keyword && !keyword.strip.empty?
      where("email LIKE ?", "%"+keyword.strip+"%").includes(:profile)
    else
      all.includes(:profile)
    end
  end

  def num_of_friends
    friended_users.count
  end

  def display_num_of_friends
    "#{num_of_friends} " + "friend".pluralize(num_of_friends)
  end

  def has_friended?(user)
    friended_users.includes(:friended_users, :profile).include?(user)
  end

  def num_of_photos
    photos.count
  end

  def last_30_days_photos
    photos.where("created_at > ?", DateTime.now - 30.days).limit(12)
  end

  def recent_posts
    posts.where("created_at > ?", DateTime.now - 100.days)
  end

end
