Rails.application.routes.draw do

  root to: 'web/pages#index'
  get "/arquivos", to: "web/pages#index"
  get "/subir_arquivos", to: "uploads#new"
  
  devise_for :users

  resources :uploads
  
  namespace :web do
    resources :pages, path: '/deputados'
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
