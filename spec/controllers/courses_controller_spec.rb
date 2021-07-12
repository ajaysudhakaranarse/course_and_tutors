# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe '#create' do
    context 'success' do
      before do
        sign_in
      end

      it 'return 201' do
        params = {
          course:
            { name: 'test',
              tutors_attributes:
              [
                { name: 'test', mobile: '9812121218' }
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
      context 'valid user' do
        before do
          sign_in
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

      context 'Invalid user' do
        it 'return invalid user' do
          request.headers['Authorization'] = '1234'

          post :create, params: {}
          response_data = JSON.parse(response.body)
          expect(response_data['message']).to eq(I18n.t('user.unauthorize'))
        end
      end
    end
  end

  describe '#index' do
    before do
      sign_in
    end

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

  describe '#add_tutors' do
    before do
      sign_in
    end

    context 'success' do
      before do
        @course = create(:course)
        tutor  = create(:tutor, course: @course)
      end

      it 'add tutors for existing course' do
        params = {
          id: @course.id,
          tutors:
            [
              { name: 'test', mobile: '9812121218' }
            ]
        }

        post :add_tutors, params: params
        response_data = JSON.parse(response.body)
        expect(response_data['status']).to eq('success')
        expect(response_data['message']).to eq(I18n.t('course.update.success'))
      end
    end

    context 'failure' do
      it 'return course not found' do
        params = { id: 100 }

        post :add_tutors, params: params
        response_data = JSON.parse(response.body)

        expect(response).to have_http_status(:not_found)
        expect(response_data['status']).to eq('failed')
        expect(response_data['message']).to eq(I18n.t('course.not_found'))
      end

      it 'will not create tutor if its already assigned to course' do
        course = create(:course)
        create(:tutor, course: course)

        params = {
          id: course.id,
          tutors:
            [
              { name: 'test', mobile: '9812121213' }
            ]
        }

        post :add_tutors, params: params
        response_data = JSON.parse(response.body)
        expect(response_data['status']).to eq('failed')
        expect(response_data['message']['tutors[0].course_id']).to eq(["tutor already assigned to #{course.name}"])
      end
    end
  end
end

def sign_in
  request.headers['Authorization'] = User.encoded_string(ENV['username'], ENV['password'])
end
