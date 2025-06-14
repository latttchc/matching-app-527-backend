Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  namespace :api do
    namespace :v1 do
      resources :test, only: [ :index ]
      resources :likes, only: %i[index create]
      resources :chat_rooms, only: %i[index show]
      resources :messages, only: %i[create]
      resources :users, only: %i[index show update]

      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations'
      }
      namespace :auth do
        resources :sessions, only: [ :index ]
      end
    end
  end
end
# Defines the root path route ("/")
# root "posts#index"
