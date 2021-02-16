Rails.application.routes.draw do

  root to: 'uploads#index'
  
  devise_for :users
  
  resources :uploads
  
  namespace :web do
    resources :pages
  end
  
  
end
