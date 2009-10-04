ActionController::Routing::Routes.draw do |map|
  map.resources :maps, :except => :destroy
  map.resources :terrain_types, :except => :destroy
  map.resources :games, :only => :show
end
