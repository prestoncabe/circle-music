CircleMusic::Application.routes.draw do
  root to: 'homes#show'

  resources :songs, only: [:new, :index, :create]
end
