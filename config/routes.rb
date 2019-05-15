Rails.application.routes.draw do

  root to: "home#landing"

  resources :projects, only: [:index, :show]

	scope 'profile' do
    resources :projects, except: [:index, :show]

		get 'index' , to: 'profile#index', as: 'my_profile'
	  get 'data' , to: 'profile#my_data', as: 'my_data'
	  get 'donations' , to: 'profile#my_donations', as: 'my_donations'
	  get 'benefits' , to: 'profile#my_benefits', as: 'my_benefits'
	  get 'social_projects' , to: 'profile#my_social_projects', as: 'my_social_projects'
		get 'offered_benefits' , to: 'profile#my_offered_benefits', as: 'my_offered_benefits'
		get 'find_sponsor/:project_id' , to: 'profile#find_sponsor', as: 'find_sponsor'

    scope 'donate' do
      post '/:id', to: 'donations#donate', as: 'donate'
    end

    scope 'requirements' do
      get '/' , to: 'profile#my_requirements', as: 'my_requirements'
      post '/', to: 'requirements#create', as:'require_sponsorship'
      post '/:id', to: 'requirements#destroy', as:'decline_sponsorship'
    end

    scope 'contracts' do
      get '/' , to: 'profile#my_contracts', as: 'my_contracts'
      get 'new/(:id)', to: 'profile#new_contract', as:'new_contract'
      post '/', to: 'contracts#create', as:'create_contract'
      post '/:id', to: 'contracts#destroy', as:'destroy_contract'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users do
    resources :benefits
  end
end
