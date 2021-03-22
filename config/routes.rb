Rails.application.routes.draw do
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  scope '(:locale)', locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
    root to: 'pages#home'
    get '/equipe', to: 'pages#team', as: :team
    get '/mentions-legales', to: 'pages#legals', as: :legals
    get '/charte-utilisation-forum', to: 'pages#charte_forum', as: :charte_forum
    get '/que-faire-si', to: 'pages#algorythm', as: :algorythm
    get '/abonnements', to: 'pages#products', as: :products
    resources :contacts, only: [:new, :create]
    get '/confirmation-envoi', to: 'contacts#message_sent', as: :message_sent
    resources :subscriptions, only: [:index, :destroy]
    resources :articles, path: 'news', only: [:index, :show, :create, :update, :destroy]
    resources :infoendos, path: 'a-savoir', only: [:index, :show, :create, :update, :destroy]
    resources :webinars, path: 'easy-lives', only: [:index, :show, :create, :update, :destroy] do
      resources :webinar_subscriptions, only: [:create]
    end
    resources :favorites, only: [:create, :destroy]
    get '/dashboard', to: 'dashboards#show'
    patch '/publish-article/:id', to: 'dashboards#publish_article', as: :publish_article
    patch '/unpublish-article/:id', to: 'dashboards#unpublish_article', as: :unpublish_article
    patch '/publish-infoendo/:id', to: 'dashboards#publish_infoendo', as: :publish_infoendo
    patch '/unpublish-infoendo/:id', to: 'dashboards#unpublish_infoendo', as: :unpublish_infoendo
    patch '/publish-webinar/:id', to: 'dashboards#publish_webinar', as: :publish_webinar
    patch '/unpublish-webinar/:id', to: 'dashboards#unpublish_webinar', as: :unpublish_webinar
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
      resources :forum_categories, only: [:new, :edit]
      resources :coupon_codes, only: [:new, :index]
      resources :subjects, only: [:new, :edit, :destroy]
    end
    #resources :coupons, only: [:create]
    #post '/coupon', to: 'coupons#use', as: :use_coupon
    resources :coupon_codes, only: [:create]
    post '/coupon', to: 'coupon_codes#use', as: :use_coupon
    resources :customer_portal_sessions, only: [:create]
    resources :daily_symptoms, path: 'agenda', only: [:index, :new, :create, :edit, :update]
    get '/graph', to: 'daily_symptoms#graph', as: :graph
    get '/forum', to: 'subjects#index', as: :forum
    resources :subjects, only: [:show, :create, :update] do
      resources :answers, only: [:create]
      resources :follow_subjects, only: [:create, :destroy]
    end
    resources :answers, only: [:destroy]
    resources :forum_categories, only: [:create, :update]
    patch '/consentement/:id', to: 'users#forum_consent', as: :consent
    patch '/admin', to: "users#become_admin", as: :become_admin
    patch '/undo-admin/:id', to: "users#undo_admin", as: :undo_admin
  end
end
