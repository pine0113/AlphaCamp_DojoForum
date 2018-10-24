Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 請依照專案指定規格來設定路由

  root 'posts#index'
  resources :posts, only: [:index, :show, :create, :new] do
    get :rights

    member do
      post :like
      post :unlike
    end

    resources :replies, only: [:index, :create]

    member do
      post :like
      post :unlike
    end
  end

  resources :category, only: [:show]

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      post :frined
      post :unfriend
      post :acceptfriend

      get :posts
      get :comments
      get :collects
      get :drafts
      get :friends
    end
  end

  resources :feeds, only: [:index]

  namespace :admin do
    resources :categories
    resources :posts, only: [:index, :destroy]
    resources :users, only: [:index] do
      member do
        post :joinadmin
      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :posts, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
