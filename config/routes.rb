Rails.application.routes.draw do
  get "search/index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  get "about", to: "static_pages#about"
  get "users", to: "users#index"

  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  get "/auth/:provider/callback" => "sessions#omniauth"
  get "auth/failure", to: redirect("/")

  get "tasks/approved", to: "users#approved_tasks"
  get "tasks/approved/show", to: "tasks#approved_show"
  get "search", to: "search#index"
  resources :users do
    get "mytasks", on: :member
  end

  get "notifications", to: "notifications#index"
  delete "notifications/:id", to: "notifications#destroy", as: :destroy_notification
  patch "notifications/:id/seen", to: "notifications#seen", as: :seen_notification

  resources :tasks do
    patch "acceptance", on: :member
    patch "status", on: :member
    patch "category", on: :member
    patch "document", on: :member
    patch "done", on: :member
    delete "attachments/:id/purge", on: :member, to: "attachments#purge", as: "purge_attachment"
    resources :subtasks do
      patch "complete", on: :member
      patch "document", on: :member
    end
  end
end
