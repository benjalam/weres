Rails.application.routes.draw do
  require 'sidekiq/web'
  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :companies, only: [:show, :edit, :update] do
    resources :candidates, only: [:show, :index] do
      collection do
        get :matching
      end
    end

    resources :company_companies, only: [:new, :create]
    resources :job_offers, only: [:index, :create, :new] do
      resources :contacted_candidates, only: [:new, :create]
    end
  end
  resources :job_offers, only: [:show, :edit, :update, :destroy]
  resources :company_companies, only: [:destroy]
  resources :candidates, only: [] do
    member do
      post :upvote
    end
  end
  resources :candidates, only: [:new, :create]
end
