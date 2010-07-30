Qajar::Application.routes.draw do |map|

  resources :subject_types

  resources :clip_types

  resources :clips

  resources :panels

  resources :classifications

  resources :subjects

  resources :appearances

  resources :images

  resources :places

  resources :calendar_types

  resources :relationships

  resources :periods

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
  match 'archive/browser/subject_type_filter/:subject_type_filter' => 'archive#browser', :as => :archive_subject_type_filter
  match 'archive/browser/period_filter/:period_filter' => 'archive#browser', :as => :archive_period_filter
  match 'archive' => 'archive#index', :as => :archive
  match 'archive/browser' => 'archive#browser', :as => :archive_browser
  match 'archive/detail/:id' => 'archive#detail', :as => :archive_detail
  map.archive_detail_slides_xml 'archive/detail/:id/slides.:format', :controller => 'archive', :action => 'slides'

  
  match 'exhibits/:id' => 'exhibits#show', :as => :show_exhibit
  match 'exhibits/detail/:id' => 'exhibits#detail', :as => :exhibit_detail
  map.exhibits 'exhibits', :controller => 'exhibits', :action => 'index'
  map.home 'home', :controller => 'home', :action => 'index'

  # hard coded pages using the pages table for their body text
  match 'about' => 'pages#page', :as => :about, :id => 1, :page_name => 'about'
  match 'contact' => 'pages#page', :as => :contact, :id => 3, :page_name => 'contact'
  match 'permissions' => 'pages#page', :as => :permissions, :id => 6, :page_name => 'permissions'
  match 'credits' => 'pages#page', :as => :credits, :id => 5, :page_name => 'credits'
  match 'faq' => 'pages#page', :as => :faq, :id => 7, :page_name => 'faq'
  match 'admin' => 'pages#admin', :as => :admin, :id => 8, :page_name => 'admin'
  
  match 'utilities' => 'utilities#index', :as => :utilities
  match 'utilities/rename_by_file_name' => 'utilities#rename_by_file_name', :as => :rename_by_file_name
  match 'utilities/rename_thumbs_by_index/:collection_id' => 'utilities#rename_thumbs_by_index', :as => :rename_thumbs_by_index
  
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
