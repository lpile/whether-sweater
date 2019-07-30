Rails.application.routes.draw do

  root to: 'welcome#index'

  namespace :api do
    namespace :v1 do
      resources :forecast, only: [:index]
      get '/backgrounds', to: 'background#index'
      resources :users, only: [:create]
      resources :sessions, only: [:create]
      resources :road_trip, only: [:create]
    end
  end
end
