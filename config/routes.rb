Rails.application.routes.draw do
  root 'pages#top'
  get '/about', to: 'pages#about'
  
  resources :users
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :topics
end