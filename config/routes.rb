DigiQuatics::Application.routes.draw do
  devise_for :users

  resources :private_lesson_details
  resources :shift_reports
  resources :attendance_records
  resources :help_desks
  resources :preventative_lists
  resources :daily_todos

  resources :pools
  resources :chemical_records

  resources :positions
  resources :certifications
  resources :certification_names

  resources :accounts do
    resources :private_lessons, shallow: true
  end

  resources :locations do
    member do
      get 'pools'
    end
  end

  resources :users do
    member do
      get 'certifications'
    end
  end

  root  'static_pages#index'

  match '/chemicals', to: 'static_pages#chemicals',    via: 'get'
  match '/manage_chemicals', to: 'static_pages#manage_chemicals', via: 'get'
  match '/maintenance', to: 'static_pages#maintenance', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/support', to: 'users#support', via: 'get'
  match '/certifications_stats',
        to: 'static_pages#certifications_stats',
        via: 'get'
  match '/user_stats', to: 'static_pages#user_stats', via: 'get'

  match '/admin_index', to: 'private_lessons#admin_index', via: 'get'
  match '/my_lessons', to: 'private_lessons#my_lessons', via: 'get'
  match '/chemical_record_stats',
        to: 'static_pages#chemical_record_stats',
        via: 'get'

  match '/inactive_index', to: 'users#inactive_index', via: 'get'
  match '/all_users', to: 'users#all_users', via: 'get'
  match '/admin_dashboard', to: 'accounts#admin_dashboard', via: 'get'
  match '/certification_expirations',
        to: 'certifications#expirations',
        via: 'get'
  match '/dashboard', to: 'static_pages#dashboard', via: 'get'

  match '/closed_index', to: 'help_desks#closed_index', via: 'get'
  match '/user_pools', to: 'pools#user_pools', via: 'get'

  # The priority is based upon order of creation: first created -> highest
  # priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id:
  # product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions
  # automatically):
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
