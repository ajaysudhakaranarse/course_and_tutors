# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'login', to: 'users#login'
  resources :courses, only: %i[create index] do
    post :add_tutors, on: :member
  end
end
