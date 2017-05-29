class School < ApplicationRecord
  has_many :school_prefs
  has_many :student_prefs
  has_many :students, through: :student_prefs

  def self.reset
    School.all.each do |school|
      avail = school.capacity
      school.update(availability: avail, assigned: nil, applied: nil, rejected: nil, accepted: nil)
    end
  end

  def apply(students_preferences, algo)
    applications = students_preferences.map{ |sp| sp.student}
    ranked = rank_by_priority(applications)
    send(algo.downcase, ranked)
  end

  def imm(ranked)
    result = {}
    if availability == 0
      result[:reject] = ranked
    elsif ranked.length <= availability
      result[:accept] = ranked
      self.update(availability: availability - ranked.length)
    else
      result[:accept] = ranked[0..availability-1]
      result[:reject] = ranked[availability..-1]
      self.update(availability: 0)
    end
    return result
  end

  def rank_by_priority (applications)
    ranked = {}
    applications.each { |student| ranked[student_prefs.find_by(student_id: student.id).rank.to_s] = student.id }
    ranked.sort.map{ |rank, student_id| student_id }
  end


end
