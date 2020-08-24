Rails.application.routes.draw do
  get 'chatrooms/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  resources :users do
    resources :experiences
  end

  resources :experiences, only: [] do
    resources :ratings, only: :create
  end

  resources :events do
    resources :rsvps, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :posts do 
    resources :comments, only: [:create, :destroy]
  end
  
  resources :offices, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
  end
  
  resources :chatrooms, only: [:index, :show] do
    resources :messages, only: :create
  end

end
