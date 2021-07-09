require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  describe '#create' do
    context 'success' do
      it 'return 201' do
        params = { 
          course: 
            { name: "test", 
              tutors_attributes: 
              [
                { name: 'ajay', mobile: '9812121218'}
              ] 
            }   
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
            { name: "test", 
              tutors_attributes: 
              [
                { name: 'ajay', mobile: '9812121218'}
              ] 
            }   
          }

        post :create, params: params
        response_data = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response_data['status']).to eq('failed')
      end
    end
  end
end