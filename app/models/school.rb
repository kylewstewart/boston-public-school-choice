class School < ApplicationRecord
  has_many :students
  has_many :school_prefs
  has_many :student_prefs
  has_many :rejections

  def self.reset
    School.all.each do |school|
      avail = school.capacity
      school.update(availability: avail)
    end
  end

  def apply(students_preferences, auction)
    applications = students_preferences.map{ |sp| sp.student}
    send(auction.method, applications)
  end

  def immediate(applications)
    ranked = rank_by_priority(applications)
    if availability == 0
      accepted = nil
      rejected = ranked
    elsif ranked.length <= availability
      accepted = ranked
      rejected = nil
      self.update(availability: availability - ranked.length)
    else
      accepted = ranked[0..availability-1]
      rejected = ranked[availability..-1]
      self.update(availability: 0)
    end
    add_accepted(accepted) if accepted
    add_rejected(rejected) if rejected
    {accepted: accepted, rejected: rejected}
  end

  def deferred(applications)
    self.students.each { |student| applications << student } if self.students.length > 0
    ranked = rank_by_priority(applications)
    if availability == 0
      accepted = nil
      rejected = ranked
    elsif ranked.length <= availability
      accepted = ranked
      rejected = nil
    else
      accepted = ranked[0..availability-1]
      rejected = ranked[availability..-1]
    end
    add_accepted(accepted) if accepted
    add_rejected(rejected) if rejected
    {accepted: accepted, rejected: rejected}
  end

  def add_rejected(student_ids)
    student_ids.each do |student_id|
      Rejection.create(school_id: self.id, student_id: student_id)
      student = Student.find(student_id)
      student.update(school_id: nil) if student.school
    end
  end

  def add_accepted(student_ids)
    student_ids.each{|student_id| Student.find(student_id).update(school_id: self.id)}
  end

  def rank_by_priority (applications)
    ranked = {}
    applications.each do |student|
      rank = student_prefs.find_by(student_id: student.id).rank.to_s
      ranked[rank] = student.id
    end
    ranked.sort.map{ |rank, student_id| student_id }
  end


end
