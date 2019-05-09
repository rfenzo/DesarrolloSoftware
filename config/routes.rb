Rails.application.routes.draw do

	get '/my_profile/index' , to: 'my_profile#index', as: 'profile'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#landing"
end
