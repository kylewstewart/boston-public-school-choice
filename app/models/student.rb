class Student < ApplicationRecord
  has_many :student_prefs
  has_many :school_prefs
  has_many :schools, through: :school_prefs
  has_many :assigneds
  has_many :schools, through: :assigneds
  has_many :accepteds
  has_many :schools, through: :accepteds
  has_many :rejecteds
  has_many :schools, through: :rejecteds
  
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
    if self.accepted
      self.accepted << school_id
      self.save
    else
      self.update(accepted: [school_id])
    end
    byebug
  end

  def update_rejected(school_id)
    byebug
  end


end
