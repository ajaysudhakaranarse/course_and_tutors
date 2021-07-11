# frozen_string_literal: true

class UsersController < ApplicationController
  def login
    username = ENV['username']
    password = ENV['password']
    token = User.encoded_string(username, password)
    render json: { token: token }
  end

  def encoded_string(username, password); end
end
