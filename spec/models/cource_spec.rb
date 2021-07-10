# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'validation' do
    it { should validate_uniqueness_of(:name) }
  end
end
