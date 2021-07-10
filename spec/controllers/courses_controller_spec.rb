# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe '#create' do
    context 'success' do
      it 'return 201' do
        params = {
          course:
            { name: 'test',
              tutors_attributes:
              [
                { name: 'ajay', mobile: '9812121218' }
              ] }
        }

        post :create, params: params
        response_data = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(response_data['status']).to eq('success')
        expect(response_data['message']).to eq(I18n.t('course.create.success'))
      end
    end

    context 'failure' do
      before do
        course = create(:course)
        create(:tutor, course: course)
      end

      it 'return 422' do
        params = {
          course:
            { name: 'mca',
              tutors_attributes:
              [
                { name: 'test', mobile: '9812121213' }
              ] }
        }

        post :create, params: params
        response_data = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_data['status']).to eq('failed')
      end
    end
  end

  describe '#index' do
    it 'Will return course with its tutors' do
      course = create(:course)
      tutor  = create(:tutor, course: course)

      get :index
      response_data = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(response_data['courses'].count).to eq 1
      expect(response_data['courses'][0]['name']).to eq(course.name)
      expect(response_data['courses'][0]['tutors'][0]['name']).to eq(tutor.name)
      expect(response_data['courses'][0]['tutors'][0]['mobile']).to eq(tutor.mobile)
    end

    it 'Will return bank it record not exists' do
      get :index
      response_data = JSON.parse(response.body)
      expect(response_data['courses']).to eq([])
    end
  end
end
