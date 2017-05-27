class StudentPref < ApplicationRecord
  belongs_to :school
  belongs_to :student
end
