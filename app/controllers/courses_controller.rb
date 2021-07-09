class CoursesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    course = Course.new(create_params)
    if course.save
      render json: {status: I18n.t('status.success'), message: I18n.t('course.create.success')}, status: :created
    else
      render json: {status: I18n.t('status.failed'), message: course.errors.messages }, status: :unprocessable_entity
    end
  end

  def index
    courses = Course.all.includes(:tutors).as_json
    render json: { courses: courses }
  end

  private

  def create_params
    params.require(:course).permit(:name, tutors_attributes: [:name, :mobile])
  end
end
