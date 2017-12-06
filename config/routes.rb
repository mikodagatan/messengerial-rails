Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'confirmations' }
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
	end

  authenticated :user do
    root :to => 'pages#welcome_page', as: :authenticated_root
  end
  root to: 'pages#landing_page'

  resources :clients do
    resources :contact_persons
    resources :addresses
  end

  get 'selections/change_contact_person'
  get 'selections/change_address'
  get 'your_tasks' => 'pages#your_jobs'

  resources :jobs


  # selections


end
