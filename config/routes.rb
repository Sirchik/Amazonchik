Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :addresses
  resources :orders, :except => [:new, :destroy] do
    resources :order_items, :only => [:destroy]
  end
  get 'get_shipping_price/:id' => 'shippings#get_shipping_price'
    
  resources :credit_cards
  resources :countries
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  
  resources :books do
    resources :ratings
  end
  
  resources :authors
  resources :categories
  post 'set_coupon/:coupon' => 'orders#set_coupon'
  post 'cart/:id'   => 'orders#add_to_cart', as: 'add_to_cart'
  get 'cart'        => 'orders#show_cart'
  get 'cart_clear'  => 'orders#clear_cart', as: 'clear_cart'
  get 'checkout'    => 'orders#checkout'
  post 'place_order' => 'orders#place'
  root 'books#bestsellers'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
