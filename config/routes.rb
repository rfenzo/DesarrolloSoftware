Rails.application.routes.draw do
  root to: "home#landing"

  scope 'projects' do
    get '(/search/:search_text)', to: 'projects#index', as: 'projects'
    get ':id', to: 'projects#show', as: 'project'
  end

	scope 'profile' do
    resources :projects, except: [:index, :show]
    resources :benefits, path: 'offered-benefits', except: [:index, :show]

		get '/' , to: 'users#dashboard', as: 'profile'
	  get 'personal-info' , to: 'users#personal_info', as: 'personal_info'
	  get 'donations' , to: 'users#donations', as: 'donations'
	  get 'earned-benefits' , to: 'users#earned_benefits', as: 'earned_benefits'
	  get 'social-projects' , to: 'users#social_projects', as: 'social_projects'
		get 'find_sponsor/:project_id' , to: 'users#find_sponsor', as: 'find_sponsor'
    get 'offered-benefits' , to: 'users#offered_benefits', as: 'offered_benefits'

    scope 'donate' do
      post '/:id', to: 'donations#create', as: 'donate'
    end

    scope 'requirements' do
      get '/' , to: 'users#requirements', as: 'requirements'
      post '/', to: 'requirements#create', as:'require_sponsorship'
      post '/:id', to: 'requirements#destroy', as:'decline_sponsorship'
    end

    scope 'contracts' do
      get '/' , to: 'users#contracts', as: 'contracts'
      get 'new/(:id)', to: 'users#new_contract', as:'new_contract'
      post '/', to: 'contracts#create', as:'create_contract'
      post '/:id', to: 'contracts#destroy', as:'destroy_contract'
    end
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
end
