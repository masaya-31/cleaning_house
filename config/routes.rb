Rails.application.routes.draw do
  # 会員用
  devise_for :members, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # 管理者側
  namespace :admin do
    resources :members, only: [:index, :edit, :update] do
      member do
        get 'posts'
        get 'comments'
      end
    end
  end

  #会員側
  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :events, only: [:new, :index, :create, :edit, :update, :destroy]
    resources :members, only: [:show, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
      get "following" => "relationships#following", as: "following"
      get "favorite"
      get "unpublish", on: :collection
      member do
        get 'email_edit'
        get 'password_edit'
        patch 'email_update'
        patch 'password_update'
      end
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
  end
end
