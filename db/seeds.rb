School.create(name: "Obama", capacity: 1, availability: 1, zone: 1)
School.create(name: "JFK", capacity: 2, availability: 2, zone: 2)
School.create(name: "Lincoln", capacity: 3, availability: 3, zone: 3)
School.create(name: "Bush", capacity: 9, availability: 9, zone: 4)
School.create(name: "Trump", capacity: 10, availability: 10, zone: 5)

Student.create(name: "Emma")
Student.create(name: "Noah")
Student.create(name: "Olivia")
Student.create(name: "Liam")
Student.create(name: "Ava")
Student.create(name: "William")
Student.create(name: "Sophia")
Student.create(name: "Mason")
Student.create(name: "Isabella")
Student.create(name: "James")
Student.create(name: "Mia")
Student.create(name: "Benjamin")
Student.create(name: "Charlotte")
Student.create(name: "Jacob")
Student.create(name: "Abigail")
Student.create(name: "Madison")
Student.create(name: "Matthew")
Student.create(name: "Avery")
Student.create(name: "Logan")
Student.create(name: "Victoria")
Student.create(name: "Samuel")
Student.create(name: "Riley")
Student.create(name: "Henry")
Student.create(name: "Sofia")
Student.create(name: "Jackson")

def add_test_scores()
  r = SimpleRandom.new
  students = Student.all
  students.each do |student|
    student = Student.find(student.id)
    score = r.normal(70, 10)
    score > 100 ? test_score = 100 : test_score = score
    student.update(test_score: test_score )
  end
end

def add_zones()
  students = Student.all
  students.each { |student| student.update(zone: rand(1..5)) }
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
add_zones()
create_student_prefs()

# strategy = Strategy.new
# # strategy.run("strategic")
# strategy.run("truethy")

# auction = Auction.new
# auction.assign_students("imm")
