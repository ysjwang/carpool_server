CarpoolServer::Application.routes.draw do
  # get "contacts/create"
  # get "contacts/show"
  # get "contacts/index"
  # get "contacts/edit"
  get "pages/home"
  get "pages/token_test_user" # THIS IS FOR TESTING PURPOSES ONLY

  # resources :contacts
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'pages#home'

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




  namespace :api, defaults: {format: :js} do
    namespace :v1 do
      resources :contacts 
     #  match '/api/v1/contacts/:id ', :controller => 'api/v1/contacts', :action => 'options', :constraints => {:method => 'OPTIONS'}, via: [:get, :post]

    end
  end
  # get '/contacts', :controller => 'contacts', :action => 'options', :constraints => {:method => 'OPTIONS'}


  

end
