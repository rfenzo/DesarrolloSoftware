Rails.application.routes.draw do

	scope 'profile' do
		get 'index' , to: 'profile#index', as: 'my_profile'
	  get 'data' , to: 'profile#my_data', as: 'my_data'
	  get 'donations' , to: 'profile#my_donations', as: 'my_donations'
	  get 'benefits' , to: 'profile#my_benefits', as: 'my_benefits'
	  get 'social_projects' , to: 'profile#my_social_projects', as: 'my_social_projects'
		get 'sponsored_projects' , to: 'profile#my_sponsored_projects', as: 'my_sponsored_projects'
		get 'offered_benefits' , to: 'profile#my_offered_benefits', as: 'my_offered_benefits'
	end

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#landing"
end
