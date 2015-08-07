class User < ActiveRecord::Base

  has_one :profile, :dependent => :destroy
  accepts_nested_attributes_for :profile

  has_many :posts, :foreign_key => :author_id, :dependent => :destroy

  has_many :likes, :foreign_key => :liker_id, :dependent => :destroy

  has_many :comments, :foreign_key => :author_id

  has_many :initiated_friendings, :foreign_key => :friender_id, :class_name => 'Friending'
  has_many :friended_users, :through => :initiated_friendings, :source => :friend_recipient

  has_many :received_friendings, :foreign_key => :friend_id, :class_name => 'Friending'
  has_many :users_friended_by, :through => :received_friendings, :source => :friend_initiator


  has_secure_password

  validates :email, :uniqueness => true, :format => { :with => /.+@.+/, :message => "format is invalid." }
  validates :password,
            :length => { :in => 6..24 },
            :allow_nil => true
  validates_confirmation_of :password


  before_create :generate_token



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

end
