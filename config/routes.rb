Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations', confirmations: 'confirmations' }
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
	end

  authenticated do
    root :to => 'pages#welcome_page', as: :authenticated
  end
  root 'pages#landing_page'

  resources :clients do
    resources :contact_persons
    resources :addresses
  end
end
