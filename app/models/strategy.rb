class Strategy

  attr_reader :all_schools, :all_students

  def initialize
    @all_schools ||= School.all
    @all_students ||= Student.all
  end

  def run(strategy)
    send(strategy.downcase)
  end

  def strategic

  end

  def truethy
    schools = School.order(:capacity)
      all_students.each do |student|
        schools.each_with_index do |school, index|
          SchoolPref.create(student_id: student.id, school_id: school.id, rank: index + 1)
        end
      end

  end

  def create_school_prefs()
  end



end
