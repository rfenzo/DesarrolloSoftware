Rails.application.routes.draw do

  get 'mis_proyectos_empresa/index'

  get 'mis_donaciones/index'

	get '/my_profile/index' , to: 'my_profile#index', as: 'profile'
	get '/mis_donaciones/index' , to: 'mis_donaciones#index', as: 'donaciones'
	get '/mis_proyectos_empresa/index' , to: 'mis_proyectos_empresa#index', as: 'proyectos_empresa'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#landing"
end
