class Statistic

  # attr_reader :students, :schools
  #
  # def initialize
  #   @students ||= Student.all
  #   @schools ||= School.all
  # end


  def self.distribution
    students ||= Student.all
    dist = {}
    students.each do |student|
      school_id = School.find_by(name: student.assigned_school).id
      rank = student.school_prefs.find_by(school_id: school_id).rank.ordinalize
      dist[rank] ? dist[rank] << student.name : dist[rank] = [student.name]
    end
    total = students.length
    dist.each do |rank, students|
      subtotal = students.length
      dist[rank] = Float(subtotal) / Float(total)
    end
    return dist
  end


end
