Rails.application.routes.draw do
  get 'users/edit'
  get 'users/show'
  get 'users/show'
  get 'users/edit'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "pages#home"

  # Add experience in the User profile (optional)
  resources :users do
    resources :experiences
  end

  resources :events do
    resources :rsvps, only: [:index, :create, :destroy]
    resources :comments, except: [:edit, :update, :destroy]
  end

  resources :posts do 
    resources :comments, except: [:edit, :update, :destroy]
  end
  
  resources :offices, only: [:index, :show] do
    resources :comments, except: [:edit, :update, :destroy]
    resources :ratings, except: [:edit, :update, :destroy]
  end
  
  resources :chatrooms, only: [:index, :show] do
    resources :messages, except: [:edit, :update, :destroy]
  end

end
