Rails.application.routes.draw do

  root to: 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      resources :backgrounds, only: [:index]
      resources :users, only: [:create]
      resources :sessions, only: [:create]
    end
  end
end
