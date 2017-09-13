Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'static_pages#root'

  namespace :api do
    resources :todos, only: [:index, :create, :show, :update, :destroy]
    # resources :todo, only: [:show, :update, :destroy]
  end
end
