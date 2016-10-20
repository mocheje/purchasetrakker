PurchaseTrakker::Application.routes.draw do
  resources :issues


  resources :issue_items


  get "inventories/index"
  match 'inventories/:id' => 'inventories#show', as: "inventory_show"

  resources :messages, only: [:new, :create]
  resources :conversations, only: [:index, :show, :destroy] do
    member do
      post :reply
      post :restore
      delete :empty_trash
      post :mark_as_read
      delete :move_to_trash
    end
  end
  get "inbox/index"

  get "profile/index"

  post "requests/search" => "requests#search", as: :request_search



  resources :stations


  devise_for :users

  get "welcome/index"


 #devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :purchases


  resources :items


  resources :request_items


  resources :requests, :except => [:delete]do
    member do
      get 'copy'
      post :approve
      post :reject
    end

  end

  resources :departments

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
  # just remember to delet# e pub:to => 'welcome#index'"admin/dashboard#index"

  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
