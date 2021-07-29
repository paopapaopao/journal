Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories

  get '/categories/new' => 'categories#new'#, as: 'new_category'
end
