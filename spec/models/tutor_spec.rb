require 'rails_helper'

RSpec.describe Tutor, type: :model do
  describe 'validation' do
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:mobile) }

    it { should allow_value("9812121212").for(:mobile) }

    context 'tutor_assign_to_course?' do
      before do
        @course = create(:course)
        create(:tutor, course: @course)
      end

      it 'return tutor already assign to course' do
        params = { 
          course: 
            { name: "test1", 
              tutors_attributes: 
              [
                { name: 'test_name', mobile: '9812121213'}
              ] 
            }   
          }
        course = Course.new(params[:course])
        course.save
        expect(course.errors.messages[:'tutors[0].course_id']).to eq(["tutor already assigned to #{@course.name}"])
      end
    end
  end
end