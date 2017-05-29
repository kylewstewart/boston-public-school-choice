class Student < ApplicationRecord

  has_many :student_prefs
  has_many :school_prefs
  has_many :schools, through: :school_prefs

  def self.reset
    Student.update_all(assigned: nil, applied: nil, rejected: nil, accepted: nil)
  end

  def school_preference
    return nil if accepted
    if !rejected
      school_prefs.order(:rank).first
    else
      school_prefs.order(:rank).reject{|pref| rejected.include?(pref.school_id)}.first
    end
  end

  def update_accepted(school_id)
    school = School.find(school_id)
    if self.accepted
      self.accepted << school
      self.save
    else
      self.update(accepted: [school])
    end
    byebug
  end

  def update_rejected(school_id)
    byebug
  end


end
