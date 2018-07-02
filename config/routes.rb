Rails.application.routes.draw do
  root "static_pages#home"

  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :products, only: %i(index show)
  resources :categories, only: :show
  resources :carts, only: :index
  resources :orders, only: %i(index new create show)
  devise_for :users
  namespace :admin do
    root "static_pages#home"

    resources :products
    resources :orders, only: %i(index show)
    resources :categories

    put "approve/:id", to: "orders#approve", as: :approve
    put "reject/:id", to: "orders#reject", as: :reject
  end

  get "add_cart/:product_id", to: "carts#add_cart", as: :add_cart
  get "remove_cart/:product_id", to: "carts#remove_cart", as: :remove_cart
  post "update_subtotal/", to: "carts#update_subtotal", as: :update_subtotal
  put "cancel/:id", to: "orders#cancel", as: :cancel
  get "filter/", to: "products#filter", as: :filter
end
