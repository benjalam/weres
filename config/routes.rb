Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :candidates, only: [:show, :index]
  resources :companies, only: [:show, :edit, :update] do
    resources :company_companies, only: [:new, :create]
    resources :job_offers, only: [:index, :create, :new] do
      resources :contacted_candidates, only: [:new, :create]
    end
  end
  resources :job_offers, only: [:show, :edit, :update, :destroy]
  resources :company_companies, only: [:destroy]
end
