Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pokedexes
  resources :skills
  resources :pokemons do
  	resources :pokemon_skills
  end
  root 'pages#home'
end
