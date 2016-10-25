namespace :pokemon_rainbow 
	desc "To populate database both Pokedex and Skill tables."
	task :drop_and_seed => 'db:seed' do
		puts "Reseeding completed."		
	end
end