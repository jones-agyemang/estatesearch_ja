Rails.application.routes.draw do
  # devise_for :lawyers
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  devise_scope :user do
    get "/lawyers/sign_up",
        to: "users/registrations#new",
        defaults: { user_type: "lawyer" },
        as: :new_lawyer_registration

    post "/lawyers",
        to: "users/registrations#create",
        defaults: { user_type: "lawyer" },
        as: :lawyer_registration
  end

  resource :dashboard

  namespace :users do
    resource :dashboard, only: :show
  end

  namespace :lawyers do
    resource :dashboard, only: :show
  end

  resources :users do
    resources :questions, only: [ :new, :create ]
  end

  resources :questions do
    resources :responses do
      member do
        patch :approve_payment
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
  root "dashboards#show"
end
