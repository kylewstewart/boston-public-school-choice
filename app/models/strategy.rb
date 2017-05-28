class Strategy

  attr_reader :schools, :students

  def initialize
    @schools ||= School.order(:capacity)
    @students ||= Student.all
  end

  def run(strategy)
    send(strategy.downcase)
  end

  def strategic
    students.each do |student|
      rank = {}
      schools.each do |school|
        index = school.student_prefs.map{ |sp| sp.student }.find_index(student)
        rank[index] ? rank[index] << school : rank[index] = [school]
      end
      i = 1
      rank.sort.each do |key, schools|
        schools.each do |school|
          SchoolPref.create(student_id: student.id, school_id: school.id, rank: i)
          i += 1
        end
      end
    end

  end

  def truethy
      students.each do |student|
        schools.each_with_index do |school, index|
          SchoolPref.create(student_id: student.id, school_id: school.id, rank: index + 1)
        end
      end

  end

end
