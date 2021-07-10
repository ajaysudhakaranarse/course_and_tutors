# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def authorize
    token = request.headers['Authorization']
    decoded = User.decoded_string(token) if token
    render json: { message: I18n.t('user.unauthorize') } unless decoded == ENV['username'] + ENV['password']
  end
end
