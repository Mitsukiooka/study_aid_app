Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'

  namespace :login do
    resources :plans do
      get 'suggest' => 'plans#suggest', on: :collection, defaults: { format: "json"}
      post 'export' => 'plans#export', on: :collection, defaults: { format: "csv" }
    end
    resources :students, except: [:index]
  end
end
