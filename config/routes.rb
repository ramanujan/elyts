=begin
   
    Get,Post, Put, Delete, Anything
    
    Possiamo definire routes che rispondono solo ai verbi HTTP GET,POST,PUT,DELETE con gli omonimi 
    metodi di Rails get,post,put,delete. Tutti questi metodi utilizzano la stessa sintassi, e lavorano 
    in maniera molto simile, me definiscono routes che rispondono solo a determinati verbi. Se non 
    importa a quali verbi dobbiamo rispondere e cioè rispondiamo con la stessa azione a tutti i verbi, 
    dobbiamo utilizzare il match(). 
    
     match "some/route", :to=>"some#controller_action"
    
    Questo route risponde a tutti i verbi: GET,POST,PUT,DELETE . Se desideriamo, possiamo utilizzare 
    match() in maniera equivalente a post(), put(), get() e delete():doc:
    
     match "some/route", :to=>"some#controller_action", :conditions=>{:method=>:get}    
       
    Ricordiamo poi che ad esempio queste linee equivalgono:
    
    get "pages/jquery" <===> get 'pages/jquery, :to=>"pages#jquery",:as=>"pages_jquery" 
     
    get "pages/jquery" <===> get 'pages/jquery, => "pages#jquery" 
    
    get "pages/jquery" <===> match "pages/jquery", :to=>"pages#jquery", :conditions=>{:method=>:get}
    
    
      
       
=end


Elyts::Application.routes.draw do
 
  
  resources :line_items, only:[:create]
  resources :carts, only:[:show]
  
  resources :store do
    collection do
      get :async_index    
      get :search
    end
    
  end
  
  
  get "images/new"

  get "static_pages/home"
  
  get '/heroku_reset', to:"static_pages#heroku_db_reset"
  
  get '/heroku_migrate', to:"static_pages#heroku_db_migrate"
  
  get '/heroku_ls', to:"static_pages#heroku_ls"
  
  get '/heroku_rake_routes', to:"static_pages#heroku_rake_routes"
  
  # JQuery attempts
  get '/jquery_sliding_effects', to: "static_pages#jquery_sliding_effects"
  
  get '/css_positioning', to: "static_pages#css_positioning"
  
  
  
  # Gestione routes per classe Utente
  
  get '/utenti/new', to:"utenti#new", as: 'new_utente'
  
  post '/utenti/', to: 'utenti#create', as: 'utenti' 
  
  # Con put non ci sono riuscito. Mettere _method=put in query string non funziona
  
  get '/utenti/:token/confirm', to: 'sessions#confirm_account_and_login', as: 'confirm_account'
  
 
  # index root path
  
  root :to => 'store#index'
 
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

  match '/signout', to: 'sessions#destroy', via: :delete

end



