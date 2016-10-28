namespace :pokemon_rainbow do
  desc "TODO"
  task :drop_and_seed => ["db:drop", "db:create", "db:migrate", "db:seed"]

end
