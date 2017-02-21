Rails.application.routes.draw do
  mount Attachinary::Engine => "/attachinary"
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :candidates, only: [:show]
  resources :companies, only: [:show, :edit, :update] do
    resources :job_offers, only: [:index, :create, :new] do
      resources :matches, only: [:show, :index, :edit, :update]
    end
  end
  resources :job_offers, only: [:show, :edit, :update, :destroy]
end
