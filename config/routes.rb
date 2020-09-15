Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    mount Thredded::Engine => '/forum'
    devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
    root to: 'pages#home'
    get '/equipe', to: 'pages#team', as: :team
    get '/mentions-legales', to: 'pages#legals', as: :legals
    get '/politique-de-confidentialité', to: 'pages#policy', as: :policy
    get '/conditions-generales', to: 'pages#conditions', as: :conditions
    get '/que-faire-si', to: 'pages#algorythm', as: :algorythm
    resources :contacts, only: [:new, :create]
    resources :products, only: :index
    resources :subscriptions, only: [:index, :destroy]
    resources :articles, only: [:index, :show, :create, :update, :destroy]
    resources :infoendos, only: [:index, :show, :create, :update, :destroy]
    resources :webinars, only: [:index, :show, :create, :update, :destroy] do
      resources :webinar_subscriptions, only: [:create]
    end
    resources :favorites, only: [:create, :destroy]
    get '/dashboard', to: 'dashboards#show'
    get '/profil/:id', to: 'users#show', as: :profil
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
  end
end
