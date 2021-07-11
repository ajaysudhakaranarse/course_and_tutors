# frozen_string_literal: true

class Tutor < ApplicationRecord
  belongs_to :course

  validates :name, presence: true
  validates :mobile, uniqueness: true
  validates :mobile, format: { with: /[0-9]{10}/, message: 'Invalid mobile number' }
  validate :tutor_assign_to_course?

  def tutor_assign_to_course?
    course = Course.joins(:tutors).where('tutors.mobile = ?', mobile)
    errors.add(:course_id, "tutor already assigned to #{course.first.name}") if course.present?
  end
end
