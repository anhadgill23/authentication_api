Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'sign_in', to: 'sessions#create'
  post 'sign_up', to: 'users#create'
end
