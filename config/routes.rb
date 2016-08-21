Rails.application.routes.draw do
  
  get 'admin' => 'admin#index'
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end





  get 'sessions/create'

  get 'sessions/destroy'

  resources :users
 
  #tells Rails to map requests 
  #to http://localhost:3000/store/index to the store controller's index action.
  #what if we make a model for it there will beno need for it
  get 'store/index'

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



# the root is http://localhost:3000/ will navigate to controller store then action index
scope '(:locale)' do
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store' , via: :all
end

end
