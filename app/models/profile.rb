class Profile < ApplicationRecord

  # belongs_to and is created by user
  belongs_to :user, inverse_of: :profile

  # validations
  validates :user, :birthday, :first_name, :last_name, presence: true, allow_nil: false
  validates :first_name, :last_name, length: { in: 2..30 }

  def name
    first_name + " " + last_name
  end

  def name=(name)
    full = name.split(" ")
    first_name = full.first
    last_name = full.last
  end

  def self.search(query)
    if query
      where("first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%")
    else
      where("")
    end
  end

end
