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
    get '/mon-profil/:id', to: 'users#show'
    resources :contacts, only: [:new, :create]
    resources :products, only: :index
    resources :subscriptions, only: [:index, :destroy]
    resources :articles, only: [:index, :show, :create, :update, :destroy]
    resources :webinars, only: [:index, :show, :create, :update, :destroy] do
      resources :webinar_subscriptions, only: [:create]
    end
    resources :favorites, only: [:create, :destroy]
    get '/dashboard', to: 'dashboards#show'
    namespace :dashboards do
      resources :articles, only: [:new, :edit]
      resources :webinars, only: [:new, :edit]
    end
  end
end
