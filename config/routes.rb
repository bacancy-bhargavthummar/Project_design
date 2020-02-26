Rails.application.routes.draw do

  default_url_options :host => "bhargav.thummar@bacancytechnology.com"
  
  root to: 'books#index'
  devise_for :users 

  get '/users/index' => 'users#index'
  delete 'users/:id' => 'users#destroy', :method => :delete, :as => :destroy_user

  get '/books/index2' => 'books#index2'
  resources :books do
    resources :comments
  end

  resources :categories
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
