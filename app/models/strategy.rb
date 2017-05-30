class Strategy < ApplicationRecord

  def self.reset
    Student.all.each do |student|
      student.school_prefs.destroy_all if student.school_prefs
    end
  end

  def self.validate_strategy(strategy)
    strategies = ["strategic", "chalk", "random"]
    if strategies.exclude?(strategy.downcase)
      puts "Invalid Strategy"
      exit!
    end
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

  def chalk
      students.each do |student|
        schools.each_with_index do |school, index|
          SchoolPref.create(student_id: student.id, school_id: school.id, rank: index + 1)
        end
      end
  end

  def random
    tot_capacity = schools.sum(:capacity)
    students.each do |student|
      rank = 0

      school_ids = []
      schools.each{|school| (tot_capacity - school.capacity).times{ |i| school_ids << school.id}}

      schools.length.times do
        rank += 1
        randomIndex = rand(0..(school_ids.length-1))
        school_id = school_ids[randomIndex]
        SchoolPref.create(student_id: student.id, school_id: school_id, rank: rank)
        school_ids.delete(school_id)
      end
    end
  end

end
