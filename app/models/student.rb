class Student < ApplicationRecord
  has_many :assigneds
  has_many :accepteds

  has_many :student_prefs
  has_many :school_prefs
  has_many :schools, through: :school_prefs
  has_many :rejections
  has_many :schools, through: :rejections

  def school_preference
    return nil if self.accepteds.length = 0
    if self.rejections = 0
      school_prefs.order(:rank).first
    else
      rejections = self.rejections.map{|reject| reject.school_id}
      school_prefs.order(:rank).reject{|pref| rejections.include?(pref.school_id)}.first
    end
  end


end
