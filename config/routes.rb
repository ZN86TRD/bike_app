Rails.application.routes.draw do

  # 管理者用 
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ユーザー用 
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # 管理者側
  namespace :admin do
    get '/' => 'dashboards#index'
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
  end

  # ユーザー側
  scope module: :public do
    root to: 'homes#top'
    get '/about' => 'homes#about', as: 'about'
    resources :posts
    
    # ユーザー名前パス
    get 'users/mypage' => 'users#show', as: 'mypage'
    resources :users, only: [:edit, :update]
  end
end
