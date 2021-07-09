class Course < ApplicationRecord
  has_many :tutors, index_errors: true

  accepts_nested_attributes_for :tutors
  validates :name, uniqueness: true
end
