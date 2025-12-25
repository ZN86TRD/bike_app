Rails.application.routes.draw do

  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
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

  # ゲストログイン
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

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
    
    resources :posts
    
    # マイページ名前パス
    get 'users/mypage' => 'users#show', as: 'mypage'
    
    # ユーザー
    resources :users, only: [:edit, :update, :destroy] do
      member do
        #退会確認_名前パス
        get 'confirm_withdraw'
      end
    end
  end
end
