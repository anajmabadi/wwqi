Qajar::Application.routes.draw do


  get "contact/new"

  get "contact/confirm"
  
  namespace "admin" do

    resources :appearances, 
      :calendar_types,
      :categories,
      :categorizations,
      :classifications,
      :clips,
      :clip_types,
      :collections,
      :owners,
      :pages,
      :periods,
      :places,
      :repositories,
      :subject_types,
      :subjects,
      :translations,
      :plots,
      :comments,
      :eras,
      :comps, 
      :sections,
      :appellations,
      :relationships,
      :people,
      :months

    resources :items do
      resources :images, :alternate_titles
      collection do
        post :show_add_passport_to_item
        post :hide_add_passport_to_item
        post :show_add_classification_to_item
        post :hide_add_classification_to_item
        post :show_add_plot_to_item
        post :hide_add_plot_to_item
        post :show_add_appearance_to_item
        post :hide_add_appearance_to_item
        post :show_add_comp_to_item
        post :hide_add_comp_to_item
        post :show_add_section_to_item
        post :hide_add_section_to_item
        post :show_add_genre_to_item
        post :hide_add_genre_to_item
        post :show_add_alternate_title_to_item
        post :hide_add_alternate_title_to_item
        get :util_update_sort_date
        get :export
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

  end

  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match 'admin' => 'admin/admin#index'
  
  
  match "find/item/:id" => 'find#item', :as => :find_item
  match "find/collection/:id" => 'find#collection', :as => :find_collection

  match 'archive/clear_my_items' => 'archive#clear_my_items', :as => :archive_clear_my_items
  match 'archive/detail/:id' => 'archive#detail', :as => :archive_detail
  
  match 'archive/detail/:id/print_friendly_transcript' => 'archive#print_friendly_transcript', :as => :archive_detail_print_friendly_transcript
  match 'archive/detail/:id/print_friendly_translation' => 'archive#print_friendly_translation', :as => :archive_detail_print_friendly_translation
  match 'archive/detail/:id/zoomify' => 'archive#zoomify', :as => :archive_detail_zoomify
  match 'archive/detail/:id/download' => 'archive#download', :as => :archive_detail_download
  match 'archive/detail/:id/email' => 'archive#download', :as => :archive_detail_email
  match 'archive/detail/:id/forget' => 'archive#forget', :as => :archive_detail_forget
  match 'archive/detail/:id/remember' => 'archive#remember', :as => :archive_detail_remember
  match 'archive' => 'archive#index', :as => :archive
  match 'archive/browser' => 'archive#browser', :as => :archive_browser
  match 'archive/browser/remember' => 'archive#remember', :as => :archive_browser_remember
  
  match 'archive/browser/drop_filter/:filter_name/(:value)' => 'archive#drop_filter', :as => :archive_browser_drop_filter
  match 'archive/collections/:id' => 'archive#collection_detail', :as => :archive_collection_detail
  match 'archive/collections' => 'archive#collections', :as => :archive_collections
  match 'archive/subjects' => 'archive#subjects', :as => :archive_subjects
  match 'archive/genres' => 'archive#genres', :as => :archive_genres
  match 'archive/people' => 'archive#people', :as => :archive_people
  match 'archive/places' => 'archive#places', :as => :archive_places
  match 'archive/advanced_search' => 'archive#advanced_search', :as => :archive_advanced_search
  
  match 'archive/detail/:id/slides.:format' => 'archive#slides', :as => 'archive_detail_slides_xml'

  
  match 'exhibits/:id' => 'exhibits#show', :as => :show_exhibit
  match 'exhibits/detail/:id' => 'exhibits#detail', :as => :exhibit_detail
  match 'exhibits' => 'exhibits#index', :as => 'exhibits'
  match 'home' => 'home#index', :as => 'home'

  # hard coded pages using the pages table for their body text
  match 'about' => 'static_pages#page', :as => :about, :id => 1, :page_name => 'about'
  match 'contact' => 'contact#new', :as => :contact
  match 'contact/create' => 'contact#create', :as => :contact_create
  match 'contact/confirm' => 'contact#confirm', :as => :contact_confirm
  match 'permissions' => 'static_pages#page', :as => :permissions, :id => 6, :page_name => 'permissions'
  match 'credits' => 'static_pages#page', :as => :credits, :id => 5, :page_name => 'credits'
  match 'faq' => 'static_pages#page', :as => :faq, :id => 7, :page_name => 'faq'
  match 'links' => 'static_pages#page', :as => :links, :id => 9, :page_name => "links"
  match 'donate' => 'static_pages#page', :as => :donate, :id => 2, :page_name => "donate"
  
  match 'admin/utilities' => 'admin/utilities#index', :as => :admin_utilities
  match 'admin/utilities/rename_by_file_name' => 'admin/utilities#rename_by_file_name', :as => :rename_by_file_name
  match 'admin/utilities/rename_thumbs_by_index/:collection_id' => 'admin/utilities#rename_thumbs_by_index', :as => :rename_thumbs_by_index
  match 'admin/utilities/rebuild_item_counts' => 'admin/utilities#rebuild_item_counts', :as => 'admin_utilities_rebuild_item_counts'
  
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
