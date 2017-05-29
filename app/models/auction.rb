class Auction < ApplicationRecord

  def assign_students(algo)
    students_preferences = get_students_preferences
    while students_preferences.length > 0
      apply_to_schools(students_preferences, algo)
      students_preferences = get_students_preferences
    end
    update_assignments
  end

  def get_students_preferences
    students.map{|student| student.school_preference}.select{|sp| sp}
  end

  def apply_to_schools(students_preferences, algo)
    students_preferences.group_by(&:school_id).each do |school_id, students_preferences|
      School.find(school_id).apply(students_preferences, algo)
    end
  end

  def update_assignments
    students.each do |student|
      student.update(assigned: true)
    end
  end

end
