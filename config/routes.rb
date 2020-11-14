Rails.application.routes.draw do
  get 'jobs/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'notifications/index'
  get 'chatrooms/show'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  resources :users do
    resources :experiences
    resources :chatrooms, only: [:create]
  end

  resources :experiences, only: [] do
    resources :ratings, only: :create
  end

  resources :rsvps, only: :destroy

  resources :events do
    resources :rsvps, only: [:create]
    resources :comments, only: [:destroy]
    post "event_comment", to: "comments#create_event_comment"
  end

  resources :posts do
    resources :comments, only: [:destroy]
    post "post_comment", to: "comments#create_post_comment"
  end

  resources :offices do
    resources :comments, only: [:destroy]
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

  resources :search, only: [:index]

  mount ActionCable.server => "/cable"

end
