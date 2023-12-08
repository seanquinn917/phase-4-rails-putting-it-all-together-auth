Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

resources :users, only: [:create, :show]
  post '/signup', to: 'users#create'
  get '/me', to: 'users#show'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :recipes, only: [:index, :create]
  get '/recipes', to: "recipes#index"
  post '/recipes', to: 'recipes#create'
end
