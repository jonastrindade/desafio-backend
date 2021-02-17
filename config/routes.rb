Rails.application.routes.draw do

  root to: 'uploads#index'
  get "/deputados", to: "web/pages#index"
  
  devise_for :users

  resources :uploads
  
  namespace :web do
    resources :pages, path: '/deputados', only: [:index, :show]
  end

  namespace :api, path: '/' do
    namespace :v1, path: '/' do
      namespace :congress_persons do
        resources :entities
        resources :expenses
        resources :calculations
      end
    end
  end
  
  
end
