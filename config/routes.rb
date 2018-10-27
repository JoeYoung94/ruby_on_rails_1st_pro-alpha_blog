Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #pages controller, home action
  root 'pages#home'

  # pages controller, about action
  get 'about', to: 'pages#about'

  resources :articles

end
