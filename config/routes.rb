Rails.application.routes.draw do
# ユーザー用
  devise_for :users, controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

# 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
# ゲストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# ユーザー用ルーティング
  scope module: :public do
    root to: 'homes#top'
    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings'
      get 'followers' => 'relationships#followers'
      member do
        get :check
        get :favorite_recipes
        get :following_recipes
      end
    end
    get 'recipes/ranking' => 'recipes#index'
    resources :recipes, except: [:index] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
      member do
        get :favorites
        get :check
      end
    end
  end

# 管理者用ルーティング
  namespace :admin do
    root to: 'homes#top'
    resources :recipes, except: [:new, :create] do
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:index, :edit, :update, :destroy]
    resources :users, except: [:new, :create] do
      member do
        get "check"
      end
    end
  end

end
