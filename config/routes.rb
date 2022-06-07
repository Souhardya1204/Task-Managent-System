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

  get '/auth/:provider/callback' => 'sessions#omniauth'
  get 'auth/failure', to: redirect('/')

  get 'tasks/approved', to: 'users#approved_tasks'
  get 'tasks/approved/show', to: 'tasks#approved_show'
  resources :users do
    get 'mytasks', on: :member
  end
  resources :tasks do
    patch 'acceptance', on: :member
    patch 'status', on: :member
    patch 'category', on: :member
    patch 'document', on: :member
    patch 'done', on: :member
    delete 'document', on: :member, to: 'tasks#delete_attachment'
    resources :subtasks do
      patch 'complete', on: :member
    end
  end
end
