# frozen_string_literal: true

class CoursesController < ApplicationController
  before_action :authorize

  def create
    course = Course.new(create_params)
    if course.save
      render json: { status: I18n.t('status.success'), message: I18n.t('course.create.success') }, status: :created
    else
      render json: { status: I18n.t('status.failed'), message: course.errors.messages }, status: :unprocessable_entity
    end
  end

  def index
    courses = Course.all.includes(:tutors).as_json(include: :tutors)
    render json: { courses: courses }
  end

  def add_tutors
    course = Course.find_by(id: params[:id])
    if course
      course.tutors.new(add_tutors_params[:tutors])
      if course.save
        render json: { status: I18n.t('status.success'), message: I18n.t('course.update.success') }
      else
        render json: { status: I18n.t('status.failed'), message: course.errors.messages }
      end
    else
      render json: { status: I18n.t('status.failed'), message: I18n.t('course.not_found') }, status: :not_found
    end
  end

  private

  def create_params
    params.require(:course).permit(:name, tutors_attributes: %i[name mobile])
  end

  def add_tutors_params
    params.permit(tutors: %i[name mobile])
  end
end
