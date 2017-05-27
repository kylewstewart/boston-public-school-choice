class Student < ApplicationRecord
  has_many :student_prefs
  has_many :school_prefs
  has_many :schools, through: :school_prefs
  has_many :student_auctions
  has_many :auctions, through: :student_auctions

end
