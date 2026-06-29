Rails.application.routes.draw do
  resources :questions

  get "up" => "rails/health#show", as: :rails_health_check
  root "questions#new"
end
