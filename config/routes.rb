Rails.application.routes.draw do
  get 'products/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
<<<<<<< HEAD
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
=======
  devise_for :users
>>>>>>> origin/master

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
<<<<<<< HEAD
  get '/best_selling', to: 'drugs#best_selling'

  root 'products#index'
  resources :customers, only: [:new, :create]
  resources :feedbacks, only: [:create]
 # config/routes.rb

resources :orders, only: [:index, :new, :create, :show] do
  member do
    get :review
  end
end


  namespace :admin do
    resources :orders, only: [:new, :create, :index]
    get '/review_order/:id', to: 'orders#review', as: 'review_order'
  end

  resources :products, only: [:index, :show] do
=======
  get 'cart', to: 'carts#show', as: :cart
  root 'products#index'
  get 'checkout', to: 'checkout#new', as: 'checkout'
  get '/best_selling', to: 'drugs#best_selling'
  resources :orders, only: [:show, :create]


  namespace :api, defaults: { format: :json } do
    post 'bot/commands', to: 'bot#process_command'
  end





  # products page 
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :member
    get 'cart', on: :collection
    put 'update_cart', on: :collection
    delete 'remove_item', on: :collection
>>>>>>> origin/master
    collection do
      get :on_sale
      get :new_products
      get :recently_updated
    end
  end

<<<<<<< HEAD
  resource :cart, only: [:show] do
    post 'add/:id', to: 'carts#add', as: 'add'
    post 'increase/:id', to: 'carts#increase', as: 'increase'
    post 'decrease/:id', to: 'carts#decrease', as: 'decrease'
    post 'remove/:id', to: 'carts#remove', as: 'remove'
  end

=======
  #categories page
>>>>>>> origin/master
  resources :categories, only: [:index, :show] do
    collection do
      get :otc
      get :prescription
      get :branded
      get :generic
    end
  end
end
