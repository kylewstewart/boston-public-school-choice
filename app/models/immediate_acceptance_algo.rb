class ImmediateAcceptanceAlgo

  attr_reader :students, :schools, :rounds

  def initiate(students, schools)
    @students = students
    @schools = schools
    @rounds = {}
  end

  def run
    round = 1
  end

  def get_student_prefs
    student_prefs = {}
    schools.each {|school| student_prefs[school.name] = []}
    students.each {|student| student_prefs[student.school_prefs[0].school.name] << student.name}
    return student_prefs
    end
  end

  def assignment


  end



end
