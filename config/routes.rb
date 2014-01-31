Barakafrites::Application.routes.draw do


  apipie
  resources :sessions, :only => [:create, :destroy],:defaults => {:format => 'json'}

  namespace :api, :defaults => {:format => 'json'},except: [:new,:edit] do
    namespace :openstc do
      resources :intervention_requests
      resources :sites
      resources :teams
      resources :departments
      resources :equipments
      resources :equipment_categories
      resources :absence_categories
      resources :task_categories
      resources :interventions
      resources :intervention_categories
      resources :site_categories
      resources :tasks do
        member do
          get 'available_vehicles'
          get 'available_equipments'
        end
      end
      resources :task_schedules

    end

    namespace :open_object do
      resources :users do
        member do
          get 'manageable_officers'
          get 'manageable_teams'
          get 'scheduled_tasks'
          get 'available_vehicles'
          get 'available_equipments'
        end
      end
      resources :groups
      resources :partners do
        member do
          get 'get_bookables'
          get 'get_bookables_pricing'
        end
      end

      resources :partner_types
      resources :partner_addresses
      resources :portable_documents
      resources :meta_datas do
	member do
	  get 'filters'
	end
      end
    end

    namespace :openresa do
      resources :bookings do
        collection do
          get 'print_planning', formats: 'html'
        end
      end
      resources :booking_lines
      resources :booking_recurrences
      get 'recurrence', to: 'booking_recurrences#get_dates'
      resources :bookables do
        member do
          get 'available_quantity'
          get 'update_available_quantity'
        end
      end
      resources :partners , controller: 'open_object/partners' do
        resources :bookables, only: [:index]
      end
    end

  end



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
