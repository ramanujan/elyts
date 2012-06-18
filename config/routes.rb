Elyts::Application.routes.draw do
 
  get "users/new"

  get "images/new"

  get "static_pages/home"
  
  get '/heroku_reset', to:"static_pages#heroku_db_reset"
  
  get '/heroku_migrate', to:"static_pages#heroku_db_migrate"
  
  
  # Gestione routes per classe Utente
  
  get '/utenti/new', to:"utenti#new", as: 'new_utente'
  
  post '/utenti/', to: 'utenti#create', as: 'utenti' 
  
  # Con put non ci sono riuscito. Mettere _method=put in query string non funziona
  
  get '/utenti/:token/confirm', to: 'sessions#confirm_account_and_login', as: 'confirm_account'
  
  root :to => 'static_pages#home'
 
  namespace :admin do
   root to: 'base#index'
   
   resources :products do
 
     member do
       put :inventory
     end
 
   end
   
   resources :users 
 
 end

=begin
  
  Il namespace costruito qui sopra, genera i seguenti RESTFUL URLs :
   
   admin_root              /admin(.:format)                  admin/base#index
   admin_products  GET    /admin/products(.:format)          admin/products#index
                   POST   /admin/products(.:format)          admin/products#create
 new_admin_product GET    /admin/products/new(.:format)      admin/products#new
edit_admin_product GET    /admin/products/:id/edit(.:format) admin/products#edit
     admin_product GET    /admin/products/:id(.:format)      admin/products#show
                   PUT    /admin/products/:id(.:format)      admin/products#update
                   DELETE /admin/products/:id(.:format)      admin/products#destroy
    

  Si noti che modificare resources do .. end con:
    
    resources do
      member do
        put :inventory
      end
    end

  Ci permette di espandere le azioni REST e di aggiungere il seguente route: 
  
  inventory_admin_product PUT    /admin/products/:id/inventory(.:format) admin/products#inventory

=end

  resources :sessions, only: [:new, :create, :destroy]

end
