require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

Dir['lib/tasks/**/*.rake'].each do |rake|
  load rake
end

task :default => :spec