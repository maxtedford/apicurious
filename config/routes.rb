Rails.application.routes.draw do

  get '/auth/twitter', as: :login
  
  root 'welcome#index'
end
