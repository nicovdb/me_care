Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    mount Thredded::Engine => '/forum'
    devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
    root to: 'pages#home'
    get '/equipe', to: 'pages#team'
    get '/mon-profil/:id', to: 'users#show'
    resources :contacts, only: [:new, :create]
    resources :products, only: :index
    resources :subscriptions, only: [:index, :destroy]
    resources :articles
    resources :favorites, only: [:create, :destroy]
  end
end
