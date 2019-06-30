Rails.application.routes.draw do

  root to: "home#landing"

  scope 'projects' do
    get '(/search/:search_text)', to: 'projects#index', as: 'projects'
    get ':id', to: 'projects#show', as: 'project'
  end

	scope 'profile' do
    resources :projects, except: [:index, :show]
    resources :benefits, path: 'offered-benefits', except: [:index, :show]

		get '/' , to: 'profile#index', as: 'profile'
	  get 'personal-info' , to: 'profile#personal_info', as: 'personal_info'
	  get 'donations' , to: 'profile#donations', as: 'donations'
	  get 'earned-benefits' , to: 'profile#earned_benefits', as: 'earned_benefits'
	  get 'social-projects' , to: 'profile#social_projects', as: 'social_projects'
		get 'find_sponsor/:project_id' , to: 'profile#find_sponsor', as: 'find_sponsor'
    get 'offered-benefits' , to: 'profile#offered_benefits', as: 'offered_benefits'

    scope 'donate' do
      post '/:id', to: 'donations#create', as: 'donate'
    end

    scope 'requirements' do
      get '/' , to: 'profile#requirements', as: 'requirements'
      post '/', to: 'requirements#create', as:'require_sponsorship'
      post '/:id', to: 'requirements#destroy', as:'decline_sponsorship'
    end

    scope 'contracts' do
      get '/' , to: 'profile#contracts', as: 'contracts'
      get 'new/(:id)', to: 'profile#new_contract', as:'new_contract'
      post '/', to: 'contracts#create', as:'create_contract'
      post '/:id', to: 'contracts#destroy', as:'destroy_contract'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
