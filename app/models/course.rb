# frozen_string_literal: true

class Course < ApplicationRecord
  has_many :tutors, index_errors: true, dependent: :destroy

  accepts_nested_attributes_for :tutors
  validates :name, uniqueness: true
end
