# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe '#login' do
    it 'return auth token' do
      get :login
      response_data = JSON.parse(response.body)
      expect(response_data['token']).to eq(User.encoded_string(ENV['username'], ENV['password']))
    end
  end
end
