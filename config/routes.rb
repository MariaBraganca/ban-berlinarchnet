Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "(:locale)", locale: /en|de/ do
    # TODO's:
    # temporarily changing root to events controller/index action
    # should be set back to root to: "pages#home"
    root to: "events#index"

    devise_for :users

    resources :users do
      resources :experiences, only: [:new, :create]
      resources :chatrooms, only: [:create]
    end

    resources :events do
      resources :rsvps, only: [:create]
      resources :comments, only: [:destroy]
      post "event_comment", to: "comments#create_event_comment"
    end

    resources :rsvps, only: [:destroy]

    resources :offices do
      resources :comments, only: [:destroy]
      resources :office_projects, only: [:new, :create]
      post "office_comment", to: "comments#create_office_comment"
    end

    resources :posts do
      resources :comments, only: [:destroy]
      post "post_comment", to: "comments#create_post_comment"
    end

    resources :openings

    resources :chatrooms, only: [:index, :show] do
      resources :messages, only: [:create]
    end

    resources :notifications, only: [:index] do
      collection do
        post :mark_as_read
      end
    end
  end

  mount ActionCable.server => "/cable"
end
