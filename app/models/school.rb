class School < ApplicationRecord
  has_many :students
  has_many :school_prefs
  has_many :student_prefs
  # has_many :students, through: :student_prefs
  has_many :rejections
  # has_many :students, through: :rejections

  def self.reset
    School.all.each do |school|
      avail = school.capacity
      school.update(availability: avail )
    end
  end

  def apply(students_preferences, algo)
    applications = students_preferences.map{ |sp| sp.student}
    send(algo.downcase, applications)
  end

  def immediate(applications)
    ranked = rank_by_priority(applications)
    if availability == 0
      add_rejected(ranked)
    elsif ranked.length <= availability
      add_accepted(ranked)
      self.update(availability: availability - ranked.length)
    else
      add_accepted(ranked[0..availability-1])
      add_rejected(ranked[availability..-1])
      self.update(availability: 0)
    end
  end

  def deferred(applications)
    applications << self.students if self.students.length > 0
    ranked = rank_by_priority(applications)
    if availability == 0
      add_rejected(ranked)
    elsif ranked.length <= availability
      add_accepted(ranked)
    else
      add_accepted(ranked[0..availability-1])
      add_rejected(ranked[availability..-1])
    end
  end

  def add_rejected(student_ids)
    student_ids.each do |student_id|
      Rejection.create(school_id: self.id, student_id: student_id)
      student = Student.find(student_id)
      studnet.update(school_id: nil) if student.school
    end
  end

  def add_accepted(student_ids)
    student_ids.each{|student_id| Student.find(student_id).update(school_id: self.id)}
  end

  def rank_by_priority (applications)
    ranked = {}
    applications.each { |student| ranked[student_prefs.find_by(student_id: student.id).rank.to_s] = student.id }
    ranked.sort.map{ |rank, student_id| student_id }
  end


end
