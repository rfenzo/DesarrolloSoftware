Rails.application.routes.draw do
  resources :projects do
    get 'donate', to: 'projects#donate', as: 'donate'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#landing"
end
