Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  get 'about', to: 'static_pages#about'
  get 'users', to: 'users#index'

  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/mytasks', to: 'tasks#my_task'
  get '/status', to: 'tasks#new_status'
  patch '/status', to: 'tasks#change_status'

  resources :users
  resources :tasks do
    patch 'acceptance', on: :member
  end
end
