Rails.application.routes.draw do
  get 'home/index'
  resources :secrets
  post 'secrets/generate', action: :generate, controller: 'secrets'
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }
  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
