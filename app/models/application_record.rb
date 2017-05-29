class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def students
    students ||= Student.all
  end

  def schools
    schools ||= School.all
  end

end
