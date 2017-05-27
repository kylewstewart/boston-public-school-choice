class School < ApplicationRecord
  has_many :school_prefs
  has_many :student_prefs
  has_many :students, through: :student_prefs

end
