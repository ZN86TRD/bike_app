Rails.application.routes.draw do

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
    resources :users, only: [:index, :show, :update]
    resources :groups, only: [:index, :destroy]
    resources :posts, only: [:show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
  end

  # ユーザー側
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'

    # ゲストログイン
    devise_scope :user do
      post 'users/guest_sign_in', to: 'sessions#guest_sign_in'
    end

    #投稿
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    #自身のいいね一覧
    get 'favorites' => 'favorites#index'

    # マイページ名前パス
    get 'users/mypage' => 'users#show', as: 'mypage'
   
    # ユーザー
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'

      member do
        #退会確認_名前パス
        get 'confirm_withdraw'
      end
    end

    #検索(ransack仕様)
    get 'search' => 'searches#index', as: 'search'

    #グループ
    resources :groups do
      resources :group_users, only: [:create, :edit, :update, :destroy]
      resource :event_notices, only: [:new, :create]
      get "event_notices/sent" => "event_notices#sent", as: "sent"
    end
  end
end