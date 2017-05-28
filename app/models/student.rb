class Student < ApplicationRecord
  has_many :student_prefs
  has_many :school_prefs
  has_many :schools, through: :school_prefs

  def self.distribution
    students = Students.all
    dist = {}
    students.each do |student|
      byebug
      student.school_prefs

    end

  end



end
