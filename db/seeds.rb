School.create(name: "Obama", capacity: 1, zone: 1)
School.create(name: "JFK", capacity: 2, zone: 2)
School.create(name: "Lincoln", capacity: 3, zone: 3)
School.create(name: "Bush", capacity: 9, zone: 4)
School.create(name: "Trump", capacity: 10, zone: 5)

Student.create(name: "Emma", zone: 1, assigned_school: nil)
Student.create(name: "Noah", zone: 1, assigned_school: nil)
Student.create(name: "Olivia", zone: 1, assigned_school: nil)
Student.create(name: "Liam", zone: 1, assigned_school: nil)
Student.create(name: "Ava", zone: 1, assigned_school: nil)
Student.create(name: "William", zone: 2, assigned_school: nil)
Student.create(name: "Sophia", zone: 2, assigned_school: nil)
Student.create(name: "Mason", zone: 2, assigned_school: nil)
Student.create(name: "Isabella", zone: 2, assigned_school: nil)
Student.create(name: "James", zone: 2, assigned_school: nil)
Student.create(name: "Mia", zone: 3, assigned_school: nil)
Student.create(name: "Benjamin", zone: 3, assigned_school: nil)
Student.create(name: "Charlotte", zone: 3, assigned_school: nil)
Student.create(name: "Jacob", zone: 3, assigned_school: nil)
Student.create(name: "Abigail", zone: 3, assigned_school: nil)
Student.create(name: "Madison", zone: 4, assigned_school: nil)
Student.create(name: "Matthew", zone: 4, assigned_school: nil)
Student.create(name: "Avery", zone: 4, assigned_school: nil)
Student.create(name: "Logan", zone: 4, assigned_school: nil)
Student.create(name: "Victoria", zone: 4, assigned_school: nil)
Student.create(name: "Samuel", zone: 5, assigned_school: nil)
Student.create(name: "Riley", zone: 5, assigned_school: nil)
Student.create(name: "Henry", zone: 5, assigned_school: nil)
Student.create(name: "Sofia", zone: 5, assigned_school: nil)
Student.create(name: "Jackson", zone: 5, assigned_school: nil)

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
create_student_prefs()
strat = Strategy.new
strat.run("strategic")
imm = Auction.new
imm.run("imm")
