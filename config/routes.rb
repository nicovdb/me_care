Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    mount Thredded::Engine => '/forum'
    devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
    root to: 'pages#home'
    get '/equipe', to: 'pages#team', as: :team
    get '/cadre-reglementaire', to: 'pages#legals', as: :legals
    get '/que-faire-si', to: 'pages#algorythm', as: :algorythm
    get '/abonnements', to: 'pages#products', as: :products
    resources :contacts, only: [:new, :create]
    resources :subscriptions, only: [:index, :destroy]
    resources :articles, path: 'news', only: [:index, :show, :create, :update, :destroy]
    resources :infoendos, path: 'a-savoir', only: [:index, :show, :create, :update, :destroy]
    resources :webinars, path: 'easy-lives', only: [:index, :show, :create, :update, :destroy] do
      resources :webinar_subscriptions, only: [:create]
    end
    resources :favorites, only: [:create, :destroy]
    get '/dashboard', to: 'dashboards#show'
    get '/profil', to: 'users#show', as: :profil
    patch '/users/:id/anonymize', to: 'users#anonymize', as: :anonymize
    resources :users, only: [:edit, :update]
    get '/profil/:user_id/informations/new', to: 'informations#new', as: :new_user_information
    post '/profil/:user_id/informations', to: 'informations#create', as: :user_information_create
    get '/profil/:user_id/informations/:id/edit', to: 'informations#edit', as: :edit_user_information
    patch '/profil/:user_id/informations/:id', to: 'informations#update', as: :user_information_update
    delete '/informations/:id', to: 'informations#destroy', as: :delete_information
    namespace :dashboards do
      resources :articles, only: [:new, :edit]
      resources :webinars, only: [:new, :edit]
      resources :infoendos, only: [:new, :edit]
    end
    resources :coupons, only: [:create]
    post '/coupon', to: 'coupons#use', as: :use_coupon
    resources :customer_portal_sessions, only: [:create]
  end
end
