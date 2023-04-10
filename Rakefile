# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

desc 'Recreate the DB and seed it'
task :db_recreate do
  `rake db:drop db:setup`
end
