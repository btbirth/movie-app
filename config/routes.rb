Rails.application.routes.draw do
  devise_for :users
  
  root 'welcome#index'
  # landing page /homepage
  get 'welcome' => 'welcome#index'

  # nested users movies routes
  resources :users, only: [:show] do
  	resources :movies, only: [:index, :show, :create, :destroy]
  end

  # resources :movies, only: [:index, :show]

  # search routes
  get 'search' => 'movies#search'
  
  get 'details/:id' => 'movies#details', as: 'details' #gives a path called details_path

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
