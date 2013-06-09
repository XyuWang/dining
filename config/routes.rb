Dining::Application.routes.draw do

  resources :products, only: [:index, :show] do
    resources :comments, only: [:index]
  end

  resources :orders, only: [:index, :create, :comments] do
    resources :comments, only: [:new]
  end
  
  resources :comments, only: [:create, :destroy]

  root to: "home#show"

  get "admin", to: "admin::admin#show"
  namespace "admin" do
    resources :storers, only: [:index, :create, :destroy]
  end

  namespace "storer" do
    get "/", to: "storer#show"
    put "/", to: "storer#update"
    put "store/open", to: "store#open"
    put "store/close", to: "store#close"
    resources :products do
      member do
        put :up, to: "products#up"
        put :down, to: "products#down"
      end
    end
    resources :orders, only: [:index, :deliver, :close] do
        put "deliver", to: "orders#deliver"
        put "close", to: "orders#close"
    end
  end

  resources :stores, only: [:index, :show]

  get "profile", to: "profile#show"
  put "profile", to: "profile#update"

  get    "cart", to: "cart#show"
  post   "cart", to: "cart#add_product"
  put    "cart", to: "cart#update"
  delete "cart", to: "cart#remove_product"
  get    "cart/total_price", to: "cart#total_price"

  devise_for :users

  match "/contact", to: "application#contact"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
