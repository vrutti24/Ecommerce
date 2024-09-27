Rails.application.routes.draw do
  root 'products#index'
  devise_for :users
  resources :products, only: [:index, :show, :new, :create] do 
    post 'add_item', to: "carts#add_item"
  end
  get 'cart', to: "carts#show"
  get 'checkout', to: "carts#checkout"
end

