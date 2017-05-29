class Statistic

  attr_reader :students, :schools

  def initialize
    @students ||= Student.all
    @schools ||= School.all
  end


  def distribution
    dist = set_dist_hash
    students.each do |student|
      rank = student.school_prefs.find_by(school_id: student.school.id).rank.ordinalize
      dist[rank] << student.name
    end
    dist.each{ |rank, studs| studs.length == 0 ?
      dist[rank] = 'None' :
      dist[rank] = ((Float(studs.length)/Float(students.length))*100.0).round(2).to_s + '%' }
    return dist.sort
  end

  def set_dist_hash
    dist = {}
    i = 0
    (schools.length).times do
      i += 1
      dist[i.ordinalize] = []
    end
    return dist
  end


end
