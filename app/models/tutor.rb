class Tutor < ApplicationRecord
  belongs_to :course

  validates :mobile, uniqueness: true 
  validates :mobile, format: {with: /[7-9]{2}[0-9]{8}/, message: 'Invalid mobile number'}
  validate :tutor_assign_to_course?

  def tutor_assign_to_course?
    course = Course.joins(:tutors).where('tutors.mobile = ?', mobile)
    if course.present?
      errors.add(:course_id, "tutor already assigned to #{course.first.name}")
    end
  end
end
