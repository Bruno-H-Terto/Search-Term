Rails.application.routes.draw do
  root "home#index"

  resources :searches, only: %i[ create ]
end
