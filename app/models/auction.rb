class Auction

  attr_reader :students, :schools
  attr_accessor :unassigned_students, :rounds, :school_availability

  def initialize
    @schools = School.all
    @students = School.all
    @unassigned_students = students
    @school_availability = {}
    @rounds = {}
  end

  def run(algo)
    set_school_availability
    rounds, round = {}, 1

    until unassigned_students.length == 0 || round > schools.length
      round_prefs = get_round_prefs(unassigned_students, round)
      assignments = send(algo.downcase, round_prefs)
      rounds[round] = [round_prefs, assignments]
      unassigned_students = update_unassigned_students
      round += 1
    end
  end

  def imm(round_prefs)
    round_prefs.each do |school_id, students|
      byebug
      school = School.find(school_id)
    end
  end

  def get_round_prefs(unassigned_students, round)
    round_prefs = {}
    schools.each {|school| round_prefs[school] = []}
    unassigned_students.each {|student| round_prefs[student.school_prefs[round-1].school] << student}
    return round_prefs
  end

  def set_school_availability
    schools.each do |school|
      school_availability[school] = school.capacity
    end
  end

end
