Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resources :questions
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "questions#index"
end
