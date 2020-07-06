Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  get '/equipe', to: 'pages#team'
  get '/mon-profil/:id', to: 'users#show'
  resources :contacts, only: [:new, :create]
  resources :products, only: :index
  resources :subscriptions, only: [:index, :destroy]
end
