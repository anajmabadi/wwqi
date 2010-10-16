Qajar::Application.routes.draw do

  namespace "admin" do

    resources :appearances, 
      :calendar_types,
      :categories,
      :categorizations,
      :classifications,
      :clips,
      :clip_types,
      :collections,
      :images,
      :owners,
      :pages,
      :periods,
      :places,
      :repositories,
      :subject_types,
      :subjects,
      :translations

    resources :items do
      collection do
        post :show_add_passport_to_item
        post :hide_add_passport_to_item
        post :show_add_classification_to_item
        post :hide_add_classification_to_item
      end
    end

    resources :passports do
      collection do
        post :add_passport_to_item
        post :add_classification_to_item
      end
    end

    resources :exhibitions do
      resources :panels
    end

    resources :people do
      resources :appellations
      resources :relationships
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match 'admin' => 'admin/admin#index'

  match 'archive/detail/:id' => 'archive#detail', :as => :archive_detail
  match 'archive' => 'archive#index', :as => :archive
  match 'archive/browser' => 'archive#browser', :as => :archive_browser

  match 'archive/detail/:id/slides.:format' => 'archive#slides', :as => 'archive_detail_slides_xml'

  
  match 'exhibits/:id' => 'exhibits#show', :as => :show_exhibit
  match 'exhibits/detail/:id' => 'exhibits#detail', :as => :exhibit_detail
  match 'exhibits' => 'exhibits#index', :as => 'exhibits'
  match 'home' => 'home#index', :as => 'home'

  # hard coded pages using the pages table for their body text
  match 'about' => 'static_pages#page', :as => :about, :id => 1, :page_name => 'about'
  match 'contact' => 'static_pages#page', :as => :contact, :id => 3, :page_name => 'contact'
  match 'permissions' => 'static_pages#page', :as => :permissions, :id => 6, :page_name => 'permissions'
  match 'credits' => 'static_pages#page', :as => :credits, :id => 5, :page_name => 'credits'
  match 'faq' => 'static_pages#page', :as => :faq, :id => 7, :page_name => 'faq'
  
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
