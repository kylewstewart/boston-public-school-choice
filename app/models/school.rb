class School < ApplicationRecord
  has_many :school_prefs
  has_many :student_prefs
  has_many :students, through: :student_prefs
  has_many :school_auctions
  has_many :auctions, through: :school_auctions

end
