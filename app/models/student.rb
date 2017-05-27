class Student < ApplicationRecord
  has_many :student_prefs
  has_many :school_prefs
  has_many :schools, through: :school_prefs

end
