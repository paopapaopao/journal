Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  devise_for :users

  authenticate :user do
    root to: 'categories#index'

    resources :categories do
      resources :tasks
    end
    resources :tasks
  end

  authenticate :user, lambda { |u| u.admin == true } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
end
