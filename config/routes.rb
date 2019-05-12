Rails.application.routes.draw do
  root to: "home#landing"

  resources :projects do
    get 'donate', to: 'projects#donate', as: 'donate'
  end

	scope 'profile' do
		get 'index' , to: 'profile#index', as: 'my_profile'
	  get 'data' , to: 'profile#my_data', as: 'my_data'
	  get 'donations' , to: 'profile#my_donations', as: 'my_donations'
	  get 'benefits' , to: 'profile#my_benefits', as: 'my_benefits'
	  get 'social_projects' , to: 'profile#my_social_projects', as: 'my_social_projects'
		get 'sponsored_projects' , to: 'profile#my_sponsored_projects', as: 'my_sponsored_projects'
		get 'offered_benefits' , to: 'profile#my_offered_benefits', as: 'my_offered_benefits'
    get 'find_sponsor' , to: 'profile#find_sponsor', as: 'find_sponsor'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :users do
    resources :benefits
  end
end
