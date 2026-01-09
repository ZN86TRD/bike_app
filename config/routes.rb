Rails.application.routes.draw do

  namespace :public do
    get 'searches/index'
  end
  # 管理者
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"

  }

  # ユーザー
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者側
  namespace :admin do
    get '/' => 'dashboards#index'
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
  end

  # ユーザー側
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    # ゲストログイン
    devise_scope :user do
      post 'users/guest_sign_in', to: 'sessions#guest_sign_in'
    end

    resources :posts do
      resources :post_comments, only: [:create, :destroy]
    end

    # マイページ名前パス
    get 'users/mypage' => 'users#show', as: 'mypage'
   
    # ユーザー
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        #退会確認_名前パス
        get 'confirm_withdraw'
      end
    end

    get 'search' => 'searches#index', as: 'search'
  end
end