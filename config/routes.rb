Rails.application.routes.draw do
  get 'users/index'
  get 'users/read/:id', to: 'users#read'
  get 'users/create'
  get 'users/update/:id', to: 'users#update'

  post 'users/insertar'
  post 'users/editar/:id', to: 'users#editar'
  post 'users/eliminar/:id', to: 'users#eliminar'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
