class StudentAuction < ApplicationRecord
  belongs_to :student
  belongs_to :auction
  
end
