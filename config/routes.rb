Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :companies, only: [:show, :edit, :update] do
    resources :job_offers do
      resources :candidates, only: [:show, :index]
    end
  end
end
