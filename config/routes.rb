AquaticsApp::Application.routes.draw do
  resources :private_lessons

  resources :positions
  resources :locations
  resources :certifications
  resources :certification_names
  resources :accounts
  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  root  'static_pages#home'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/signin',  to: 'sessions#new',         via: 'get'
  match '/signout', to: 'sessions#destroy',     via: 'delete'
  match '/signup',  to: 'users#new',            via: 'get'
  match '/chemicals',    to: 'static_pages#chemicals',    via: 'get'
  match '/manage_chemicals',    to: 'static_pages#manage_chemicals',    via: 'get'
  match '/maintenance',   to: 'static_pages#maintenance',   via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/support',  to: 'users#support',            via: 'get'
  match '/attendance',    to: 'static_pages#attendance',    via: 'get'
  match '/certifications_stats', to: 'static_pages#certifications_stats',   via: 'get'
  match '/user_stats',   to: 'static_pages#user_stats',   via: 'get'
  match '/my_lessons',  to: 'private_lessons#my_lessons',            via: 'get'

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
