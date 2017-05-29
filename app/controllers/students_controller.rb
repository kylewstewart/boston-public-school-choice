class StudentsController < ApplicationController

  def index
    @students = Student.all
    @schools = School.all
    @stats = Statistic.new
  end

end
