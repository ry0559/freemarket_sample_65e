Rails.application.routes.draw do
  post "products/:id/purchase/pay", to: "purchase#pay", as: :pay_product_purchase_index
  get "purchase/index/:id", to: "purchase#index", as: :purchase_index
  get "purchase/done/:id", to: "purchase#done", as: :purchase_done
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: "users/registrations",
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  devise_scope :user do
    get 'step1', to: 'users/registrations#step1'
    post 'step1',  to: 'users/registrations#create_step1'
    get 'users/sign_in', to: 'users/sessions#new'
  end
  root 'users#index'
  get "users/logout", to: "users#logout"
  get "users/identification", to: "users#identification"
  get "products/detail/:id", to: "products#detail", as: :products_detail
  get "users/profile", to: "users#profile"
  get "users/edit", to: "users#edit"
  get "signup", to: "signup#index"
  get 'products/error'
  get 'users/listing', to: "users#listing"
  get 'users/progress', to: "users#progress"
  get 'users/completed', to: "users#completed"

  resources :card_signup, only: [:new, :create]

  resources :card, only: [:create, :show, :edit] do
    collection do
      post 'delete', to: 'card#delete'
      post 'show', to: 'card#show'
      post 'step3', to: 'card#step3'
      post 'step4', to: 'card#step4'
    end
    member do
      get 'add'
    end
  end 

  resources :step, only: [:create] do
    member do
      get 'step3'
    end
  end

  resources :products do
    collection do
      get 'category_children' 
      get 'category_grandchildren'
    end
    
    resources :purchase, only: [:index] do
      collection do
        post 'pay', to: 'purchase#pay'
        get 'done', to: 'purchase#done'
      end
    end
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end
  get :dynamic_select_category, to: 'products#dynamic_select_category'
  resources :users, only: [:index, :show, :edit, :update, :new]
  resources :signup do
    collection do
      get 'step1'
      post 'step2'
      post 'step3'  #入力が全て完了
      get 'step4'  #登録完了後
    end
  end
end
