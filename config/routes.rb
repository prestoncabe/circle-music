CircleMusic::Application.routes.draw do
  root to: 'homes#show'

  resources :songs, only: [:new, :index, :create, :show, :destroy] do
    resources :links, only: [:new, :create]
  end
  resource :search, only: [:show]
end
