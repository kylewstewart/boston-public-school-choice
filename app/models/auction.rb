class Auction < ApplicationRecord
  has_many :student_auctions
  has_many :students, through: :student_auctions
  has_many :school_auctions
  has_many :schools, through :school_auctions

  def run(algo)
    clear_school_assignments
    rounds, round, unassigned_students = {}, 1, students

    until unassigned_students.length == 0 || round > schools.length
      rounds[round] = [round_prefs(unassigned_students, round), assignments(round_prefs, algo)]
      unassigned_students = get_unasigned_students
      round += 1
    end

    return rounds
  end


  def round_prefs(unassigned_students, round)
    student_round_prefs = {}
    schools.each {|school| student_round_prefs[school.name] = []}
    unassigned_students.each {|student| student_round_prefs[student.school_prefs[round-1].school.name] << student.name}
    return student_round_prefs
  end

  def self.assignments(round_prefs)
    byebug

  end

  def get_unasigned_students
    students.where(assigned_school: nil)
  end

  def clear_school_assignments
    students.each {|student| student.update(assigned_school: nil)}
  end

  def students
    students ||= Student.all
  end

  def schools
    schools ||= School.all
  end
  
end
