class StudentsController < ApplicationController

  def index
    @students = Student.all
    @schools = School.all
  end

end
