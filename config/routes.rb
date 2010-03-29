Qajar::Application.routes.draw do |map|
  resources :pages

  resources :translations

  resources :categorizations

  resources :categories


  resources :exhibitions

  resources :owners

  resources :appellations

  resources :people

  resources :collections

  resources :items

  # The priority is based upon order of creation:
  # first created -> highest priority.

  map.archive 'archive', :controller => 'archive', :action => 'index'
  map.exhibits 'exhibits', :controller => 'exhibits', :action => 'index'
  map.home 'home', :controller => 'home', :action => 'index'
  map.about 'about', :controller => 'pages', :action => 'about', :id => 1
  map.donate_materials 'donate_materials', :controller => 'pages', :action => 'donate_materials', :id => 2
  map.contact 'contact', :controller => 'pages', :action => 'contact', :id => 3
  map.news 'news', :controller => 'pages', :action => 'news', :id => 4
  map.permissions 'permissions', :controller => 'pages', :action => 'permissions', :id => 5
  map.sponsors 'sponsors', :controller => 'pages', :action => 'sponsors', :id => 6
  map.help 'help', :controller => 'pages', :action => 'help', :id => 7

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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  root :to => "home#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
