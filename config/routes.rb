Rails.application.routes.draw do
  devise_for :users, :controllers => {sessions: 'sessions'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # 請依照專案指定規格來設定路由

  root 'posts#index'
  resources :posts, only: [:index, :show, :create, :new, :edit, :update, :destroy] do
    get :rights

    resources :replies, only: [:create]

  end

  resources :replies, only: [:destroy, :edit, :update]

  resources :category, only: [:show]

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :posts
      get :comments
      get :collects
      get :drafts
      get :friends
    end
  end

  resources :feeds, only: [:index]

  namespace :admin do
    root 'categories#index'
    resources :categories
    resources :users, only: [:index] do
      member do
        post :joinadmin
        post :removeadmin
      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"

      resources :posts, only: [:index, :create, :show, :update, :destroy] do
        member do
          post :collect
          post :uncollect
        end
      end

      resources :users, only: [] do
        member do
          post :friend
          post :unfriend
          post :acceptfriend
        end
      end


    end
  end
end
