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

  get "up" => "rails/health#show", as: :rails_health_check
  root "questions#index"
end
