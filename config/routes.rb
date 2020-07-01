Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: 'pages#home'
  resources :products, only: :index
  resources :subscriptions, only: [:index, :destroy]
end
