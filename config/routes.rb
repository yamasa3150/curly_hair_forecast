Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'top#index'
  post '/callback' => 'line_bot#callback'
  resources :push_settings
end
