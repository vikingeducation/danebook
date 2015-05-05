class Profile < ActiveRecord::Base

  belongs_to :user

  validates :day, :month, :year, :gender,
                                presence: true

  validates :gender, inclusion: { in: ["Male", "Female", "Another Identity", "Not Provided", "Rather Not Say"] }
  validates :day, inclusion: { in: (1..31) }
  validates :month, inclusion: { in: (1..12) }
  validates :year, inclusion: { in: (1901..Time.now.year) }

  validates :college, length: { maximum: 25 }
  validates :hometown, length: { maximum: 35 }
  validates :currently_lives, length: { maximum: 35 }
  validates :telephone, length: { maximum: 25 }

  validates :words_to_live_by, length: { maximum: 140 }
  validates :about_me, length: { maximum: 400 }



  # Birthday is combo of Day, Month, and Year columns for now
  # TODO: refactor to use Datetime field and combined date helpers
  def birthday
    "#{month}\/#{day}\/#{year}"
  end

  #takes a string like '03/29/1994' and sets the appropriate date fields
  def birthday= (datestring)
    date = datestring.split("\/")
    self.month = date[0]
    self.day = date[1]
    self.year = date[2]
  end
end
