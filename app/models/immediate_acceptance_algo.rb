class ImmediateAcceptanceAlgo

  attr_reader :students, :schools, :rounds

  def initiate(students, schools)
    @students = students
    @schools = schools
    @rounds = []
  end

  def run
    round = {}
    schools.each {|school| round[school.name] = []}
    students.each {|student| round[student.school_prefs[0].school.name] << student.name}


    end

  end




end
