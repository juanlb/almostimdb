Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :movies, only: [:index, :show, :create, :update, :destroy] do
        resources :directors, only: [:index, :create, :destroy]
        resources :producers, only: [:index, :create, :destroy]
        resources :cast, only: [:index, :create, :destroy]
      end
      resources :people, only: [:index, :show, :create, :update, :destroy]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
