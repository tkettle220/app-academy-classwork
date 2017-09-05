Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resource :session
  resources :subs
  resources :posts do
    resources :comments, only: [:show]
  end
  resources :comments, only: [:create, :destroy]
  post '/posts/:id/upvote', to: 'posts#upvote'
  post '/posts/:id/downvote', to: 'posts#downvote'
  post '/posts/:id/resetvote', to: 'posts#resetvote'
  post '/comments/:id/upvote', to: 'comments#upvote'
  post '/comments/:id/downvote', to: 'comments#downvote'
  post '/comments/:id/resetvote', to: 'comments#resetvote'

end
