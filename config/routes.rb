Rails.application.routes.draw do
  post 'api/login' => 'customer_token#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'react#index'
  namespace :api do 
  	resources :customer, only: [:index, :create, :destroy, :update] 
  end

end
