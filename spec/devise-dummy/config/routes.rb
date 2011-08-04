Dummy::Application.routes.draw do
  devise_for :admins

  devise_for :users

  resources :articles, :posts, :concertos do
    collection do
      get :admin
      get :guest
      get :admin_account
    end

    resources :comments
  end

  resources :users do
    collection do
      get :admin
      get :guest
      get :admin_account
    end
  end

  resources :accounts do
    collection do
      get :admin
      get :guest
      get :admin_account
    end
  end

  [:user, :guest, :admin].each do |role|
    match "login_#{role}/:id" => "sessions#login_#{role}"
    match "logout_#{role}/:id" => "sessions#logout_#{role}"
  end

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
  root :to => "main#index"

end
