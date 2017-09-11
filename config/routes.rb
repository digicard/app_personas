Rails.application.routes.draw do
  get 'home/index'

  get 'assets/images'

  get 'persons/list_view/:id', to: 'persons#list_view', as: 'persons_list_view'
  post 'persons/list_view/', to: 'persons#list_view'
  match 'persons/list_view', to: 'persons#list_view', via: :get

  get 'persons/icon_view/:id', to: 'persons#icon_view', as: 'persons_icon_view'

  get 'person/show_person/:id', to: 'persons#show_person', as: 'show_person'

  get 'person/show_image/:id', to: 'persons#show_image', as: 'show_image'

  #get 'person/blob_to_file/:id', to: 'persons#blob_to_file', as: 'blob_to_file'

  get 'persons/show_person'
  post 'persons/show_person'
  post 'persons/new'

  post 'persons/create_person_ca'
  
  patch 'persons/:id/ca', to: 'persons#update_person_ca', as: 'update_person_ca'
  #put 'persons/:id', to: 'persons#update_person_ca'

  resources :persons

  root 'home#index'
end
