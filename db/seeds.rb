School.create(name: "JFK Elementary", availability: 5, zone: 1)
School.create(name: "Lincoln Elementary", availability: 5, zone: 2)
School.create(name: "Washington Elementary", availability: 5, zone: 3)

Student.create(name: "Emma", zone: 1)
Student.create(name: "Noah", zone: 1)
Student.create(name: "Olivia", zone: 1)
Student.create(name: "Liam", zone: 1)
Student.create(name: "Ava", zone: 1)
Student.create(name: "William", zone: 2)
Student.create(name: "Sophia", zone: 2)
Student.create(name: "Mason", zone: 2)
Student.create(name: "Isabella", zone: 2)
Student.create(name: "James", zone: 2)
Student.create(name: "Mia", zone: 3)
Student.create(name: "Benjamin", zone: 3)
Student.create(name: "Charlotte", zone: 3)
Student.create(name: "Jacob", zone: 3)
Student.create(name: "Abigail", zone: 3)

def add_test_scores()
  r = SimpleRandom.new
  students = Student.all
  students.each do |student|
    student = Student.find(student.id)
    student.update(test_score: r.normal(75, 15))
  end
end

def create_school_prefs()
  students = Student.all
  schools = School.all
    students.each do |student|
      schools.shuffle.each_with_index do |school, index|
        SchoolPref.create(student_id: student.id, school_id: school.id, rank: index + 1)
      end
    end
end

def create_student_prefs()
  schools = School.all

  schools.each do |school|
    rank = 1

    students_in_zone = Student.where(zone: school.zone).order(test_score: :desc)
    students_in_zone.each do |student|
      StudentPref.create(school_id: school.id, student_id: student.id, rank: rank)
      rank += 1
    end

    students_not_in_zone = Student.where("zone != #{school.zone}").order(test_score: :desc)
    students_not_in_zone.each do |student|
      StudentPref.create(school_id: school.id, student_id: student.id, rank: rank)
      rank += 1
    end
  end
end

add_test_scores()
create_school_prefs()
create_student_prefs()
