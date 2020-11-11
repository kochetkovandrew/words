Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "games/:id/field", to: 'games#field'
  put "games/:id/reset_timer", to: 'games#reset_timer'
  resources :games
end
