class Student < ApplicationRecord

  belongs_to :school, optional: true
  has_many :student_prefs
  has_many :school_prefs
  has_many :schools, through: :school_prefs
  has_many :rejections
  has_many :schools, through: :rejections

  def self.reset
    Student.update_all(school_id: nil, assigned: false)
  end

  def school_preference
    return nil if self.school
    if self.rejections.length == 0
      school_prefs.order(:rank).first
    else
      rejections = self.rejections.map{|reject| reject.school_id}
      school_prefs.order(:rank).reject{|pref| rejections.include?(pref.school_id)}.first
    end
  end


end
