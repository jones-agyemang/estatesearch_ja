Rails.application.routes.draw do
  devise_for :users

  namespace :users do
    resource :dashboard, only: :show
  end

  namespace :lawyers do
    resource :dashboard, only: :show
  end

  resources :users do
    resources :questions
  end

  resources :questions do
    resources :responses do
      member do
        patch :approve_payment
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "questions#index"
  # root "dashboard#index"
end
