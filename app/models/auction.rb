class Auction < ApplicationRecord
  has_many :roundlogs

  def self.run(algo, strategy)
    self.validate_algo(algo)
    Strategy.validate_strategy(strategy)
    self.reset
    auction = Auction.create(method: algo.downcase, strategy: strategy.downcase)
    strat = Strategy.new
    strat.run(strategy)
    auction.run(algo)
  end

  def self.reset
    Student.reset
    School.reset
    Strategy.reset
  end

  def self.validate_algo(algo)
    algorithms = ["immediate", "deferred"]
    if algorithms.include?(algo.downcase)
    else
      puts "Invalid Alogrith"
      exit!
    end
  end


  def run(algo)
    round = 0
    student_preferences = get_student_preferences
    while student_preferences.length > 0
      round += 1
      apply_to_schools(student_preferences, self, round)
      student_preferences = get_student_preferences
    end
    update_assignments
  end

  def get_student_preferences
    students.map{ |student| student.school_preference}.select{ |sp| sp}
  end

  def apply_to_schools(student_preferences, auction, round)
    student_preferences.group_by(&:school_id).each do |school_id, student_preferencs|
      school_response = School.find(school_id).apply(student_preferences, auction)
      create_log(round: round, school_id: school_id, student_preferences: student_preferencs,
        accepted: school_response[:accepted], rejected: school_response[:rejected])
    end
  end

  def update_assignments
    students.each do |student|
      student.update(assigned: true)
    end
  end

  def create_log(log={})
    applicants = log[:student_preferences].map{|sp| sp.student_id}
    Roundlog.create(auction_id: self.id, round: log[:round], school_id: log[:school_id],
      applicants: applicants, accepted: log[:accepted], rejected: log[:rejected])
  end

end
