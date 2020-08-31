Rails.application.routes.draw do
  get 'notifications/index'
  get 'chatrooms/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  resources :users do
    resources :experiences
    resources :rsvps
    resources :chatrooms, only: [:create]
  end

  resources :experiences, only: [] do
    resources :ratings, only: :create
  end

  resources :events do
    resources :rsvps, only: [:create, :destroy]
    resources :comments, only: [:destroy]
    post "event_comment", to: "comments#create_event_comment"
  end

  resources :posts do
    resources :comments, only: [ :new, :create, :destroy]
    post "post_comment", to: "comments#create_post_comment"
  end

  resources :offices, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    post "office_comment", to: "comments#create_office_comment"
  end

  resources :chatrooms, only: [:index, :show] do
    resources :messages, only: :create
  end

  resources :openings, only: [:index, :show]

  resources :notifications, only: [:index] do
    collection do
      post :mark_as_read
    end
  end

end
