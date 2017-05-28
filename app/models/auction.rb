class Auction

  attr_reader :all_students, :all_schools
  attr_accessor :unassigned, :rounds, :avail

  def initialize
    @all_schools ||= School.all
    @all_students ||= Student.all
    @unassigned = []
    @avail = {}
    @rounds = {}
  end

  def run(algo)
    set_school_avail
    set_unassigned
    round = 1
    until unassigned.length == 0 || round > all_schools.length
      round_prefs = get_round_prefs(unassigned, round)
      assignments = send(algo.downcase, round_prefs)
      rounds[round] = [round_prefs, assignments]
      round += 1
    end
    return rounds
  end

  def imm(round_prefs)
    assigned = {}
    round_prefs.each do |school, students|
      next if avail[school] == 0
      assigned[school] = school.student_prefs.select{ |student_pref| students.include?(student_pref.student) }
      .map{ |student_pref| student_pref.student }[0..avail[school]-1]
    end
    update(assigned)
    return assigned
  end

  def get_round_prefs(unassigned_students, round)
    round_prefs = {}
    all_schools.each {|school| round_prefs[school] = []}
    unassigned_students.each {|student| round_prefs[student.school_prefs[round-1].school] << student}
    return round_prefs
  end

  def set_unassigned
    all_students.each{ |student| unassigned << student }
  end

  def set_school_avail
    all_schools.each do |school|
      avail[school] = school.capacity
    end
  end

  def update(assigned)
    assigned.each do |school, students|
      avail[school] = school.capacity - students.length
      students.each do |student|
        student.update(assigned_school: school.name)
        unassigned.delete(student)
      end
    end
  end

end
