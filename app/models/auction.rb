class Auction < ApplicationRecord

  def assign_students(algo)
    students_preferences = get_students_preferences
    while students_preferences.length > 0
      round_results = apply_to_schools(students_preferences, algo)
      update_students(round_results)
      students_preferences = get_students_preferences
    end
    update_assignments
  end

  def get_students_preferences
    students.map{ |student| student.school_preference }.select{ |sp| sp }
  end

  def apply_to_schools(students_preferences, algo)
    round_results = {}
    students_preferences.group_by(&:school_id).each do |school_id, students_preferences|
      round_results[school_id] =  School.find(school_id).apply(students_preferences, algo)
    end
    return round_results
  end

  def update_students(round_results)
    round_results.each do |school_id, result|
      result[:accept].each{ |student_id| Student.find(student_id).update_accepted(school_id) } if result[:accept]
      # result[:reject].each{ |student_id| Student.find(student_id).update_rejected(school_id) } if result[:reject]
    end
  end













  # def run(algo)
  #   set_school_avail
  #   set_unassigned
  #   round = 1
  #   until unassigned.length == 0 || round > all_schools.length
  #     round_prefs = get_round_prefs(unassigned, round)
  #     assignments = send(algo.downcase, round_prefs)
  #     rounds[round] = [round_prefs, assignments]
  #     round += 1
  #   end
  #   return rounds
  # end
  #
  # def imm(round_prefs)
  #   assigned = {}
  #   round_prefs.each do |school, students|
  #     next if avail[school] == 0
  #     assigned[school] = school.student_prefs.select{ |student_pref| students.include?(student_pref.student) }
  #     .map{ |student_pref| student_pref.student }[0..avail[school]-1]
  #   end
  #   update_db(assigned)
  #   return assigned
  # end
  #
  # def get_round_prefs(unassigned_students, round)
  #   round_prefs = {}
  #   all_schools.each {|school| round_prefs[school] = []}
  #   unassigned_students.each {|student| round_prefs[student.school_prefs[round-1].school] << student}
  #   return round_prefs
  # end

  # def set_unassigned
  #   all_students.each{ |student| unassigned << student }
  # end
  #
  # def set_school_avail
  #   all_schools.each do |school|
  #     avail[school] = school.capacity
  #   end
  # end

  # def update_db(assigned)
  #   assigned.each do |school, students|
  #     avail[school] = school.capacity - students.length
  #     students.each do |student|
  #       student.update(assigned_school: school.name)
  #       unassigned.delete(student)
  #     end
  #   end
  # end



end
