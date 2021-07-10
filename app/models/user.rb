# frozen_string_literal: true

class User < ApplicationRecord
  def self.encoded_string(username, password)
    Base64.encode64(username + password)
  end

  def self.decoded_string(encoded)
    Base64.decode64(encoded)
  end
end
