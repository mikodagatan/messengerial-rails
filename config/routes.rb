Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'users/confirmations' }
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
	end

  authenticated :user do
    root :to => 'pages#welcome_page', as: :authenticated_root
  end
  root to: 'pages#landing_page'

  resources :clients do
    resources :target_clients do
      resources :contact_persons
      resources :addresses
  end
  end

  get 'selections/change_contact_person'
  get 'selections/change_address'
  get 'selections/change_target_client'
  get 'your_tasks' => 'pages#your_tasks'
  get 'your_requests' => 'pages#your_requests'
  get 'print_tasks' => 'pages#print_tasks'
  get 'update_notification_unread' => 'notifications#update_notification_unread'
  get 'update_notification_unread_all' => 'notifications#update_notification_unread_all'

  get 'location_report' => 'reports#location_report'

  resources :tasks do
    get 'history' => 'tasks#history'
    get 'resource_notes' => "tasks#resource_notes"
    get 'pass_task' => 'tasks#pass_task'
    post 'pass_task2' => 'tasks#pass_task2'
    collection do
      get :pass_all_tasks
      post :pass_all_tasks2
    end
  end

  get 'notifications/link_through'
  get 'notifications/index'

  # selections
  mount ActionCable.server => '/cable'


  require 'resque/server'
  mount Resque::Server, at: '/resque'


end
