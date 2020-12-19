Rails.application.routes.draw do
  root "books#index"
 post '/' =>'books#import', as: 'import'
 get 'info' =>'books#info', as: 'info'

  resources :books

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  

end

