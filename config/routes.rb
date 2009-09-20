ActionController::Routing::Routes.draw do |map|
  map.resources :games, :only => :show
  
  # Default routes: let's kill these asap
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
