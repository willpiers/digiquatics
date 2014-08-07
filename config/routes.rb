DigiQuatics::Application.routes.draw do
  resources :email_groups

  devise_for :users

  resources :attendance_records
  resources :availabilities
  resources :certifications
  resources :certification_names
  resources :chemical_records
  resources :daily_todos
  resources :help_desks
  resources :packages
  resources :pools
  resources :positions
  resources :preventative_lists
  resources :shift_reports
  resources :shifts
  resources :skill_levels
  resources :slide_inspections
  resources :slide_inspection_tasks
  resources :sub_requests
  resources :time_off_requests

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

  # Availability
  match '/my_availability', to: 'availabilities#my_availability', via: 'get'

  # Chemicals
  match '/chemicals', to: 'static_pages#chemicals',    via: 'get'
  match '/manage_chemicals', to: 'static_pages#manage_chemicals', via: 'get'
  match '/chemical_record_stats',
        to: 'static_pages#chemical_record_stats',
        via: 'get'
  match '/chemical_record_stats',
        to: 'static_pages#chemical_record_stats',
        via: 'post'

  # Default Static Pages
  match '/maintenance', to: 'static_pages#maintenance', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/instructions', to: 'static_pages#instructions', via: 'get'
  match '/support', to: 'users#support', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/tos', to: 'static_pages#tos', via: 'get'
  match '/dashboard', to: 'static_pages#dashboard', via: 'get'
  match '/availability', to: 'static_pages#availability', via: 'get'

  # Certifications
  match '/certifications_stats',
        to: 'static_pages#certifications_stats',
        via: 'get'

  # Schedule
  match '/my_schedule', to: 'shifts#my_schedule', via: 'get'

  # Users
  match '/user_stats', to: 'static_pages#user_stats', via: 'get'
  match '/inactive_index', to: 'users#inactive_index', via: 'get'
  match '/all_users', to: 'users#all_users', via: 'get'

  # Private Lessons
  match '/private_lesson_stats', to: 'static_pages#private_lesson_stats', via: 'get'
  match '/admin_index', to: 'private_lessons#admin_index', via: 'get'
  match '/completed_admin_index', to: 'private_lessons#completed_admin_index', via: 'get'
  match '/my_lessons', to: 'private_lessons#my_lessons', via: 'get'
  match '/thank_you', to: 'private_lessons#thank_you', via: 'get'
  match '/my_lessons', to: 'private_lessons#my_lessons', via: 'get'

  # Sub Requests
  match '/processed_sub_requests', to: 'sub_requests#processed', via: 'get'
  match '/my_sub_requests', to: 'sub_requests#my_sub_requests', via: 'get'
  match '/admin_sub_requests', to: 'sub_requests#admin_index', via: 'get'

  # Time Off
  match '/archived_time_off_requests',
        to: 'time_off_requests#archived_time_off_requests',
        via: 'get'
  match '/my_time_off_requests',
        to: 'time_off_requests#my_time_off_requests',
        via: 'get'

  # Admin Dashboard
  match '/admin_dashboard', to: 'accounts#admin_dashboard', via: 'get'

  # Help Desk
  match '/closed_index', to: 'help_desks#closed_index', via: 'get'
end
