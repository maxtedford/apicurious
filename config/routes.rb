Rails.application.routes.draw do

  get '/auth/twitter', as: :login
  get '/auth/twitter/callback', to: 'sessions#create'
  
  root 'welcome#index'
end
