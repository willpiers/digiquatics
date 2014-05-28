DigiQuatics::Application.routes.draw do
  devise_for :users

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
  resources :slide_inspections
  resources :slide_inspection_tasks

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

  root 'static_pages#landing'

  match '/chemicals', to: 'static_pages#chemicals',    via: 'get'
  match '/manage_chemicals', to: 'static_pages#manage_chemicals', via: 'get'
  match '/maintenance', to: 'static_pages#maintenance', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'

  match '/support', to: 'users#support', via: 'get'
  match '/certifications_stats',
        to: 'static_pages#certifications_stats',
        via: 'get'
  match '/user_stats', to: 'static_pages#user_stats', via: 'get'
  match '/private_lesson_stats', to: 'static_pages#private_lesson_stats', via: 'get'

  match '/admin_index', to: 'private_lessons#admin_index', via: 'get'
  match '/completed_admin_index', to: 'private_lessons#completed_admin_index', via: 'get'
  match '/my_lessons', to: 'private_lessons#my_lessons', via: 'get'
  match '/thank_you', to: 'private_lessons#thank_you', via: 'get'
  match '/chemical_record_stats',
        to: 'static_pages#chemical_record_stats',
        via: 'get'
  match '/chemical_record_stats',
        to: 'static_pages#chemical_record_stats',
        via: 'post'

  match '/inactive_index', to: 'users#inactive_index', via: 'get'
  match '/all_users', to: 'users#all_users', via: 'get'
  match '/admin_dashboard', to: 'accounts#admin_dashboard', via: 'get'
  match '/certification_expirations',
        to: 'certifications#index',
        via: 'get'
  match '/dashboard', to: 'static_pages#dashboard', via: 'get'

  match '/closed_index', to: 'help_desks#closed_index', via: 'get'

  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/tos', to: 'static_pages#tos', via: 'get'

end
