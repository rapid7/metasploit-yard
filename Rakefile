require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

gem_specification = Gem::Specification.find_by_name('metasploit-yard')

Dir[File.join(gem_specification.gem_dir, 'lib', 'tasks', '**', '*.rake')].each do |rake|
  load rake
end

task :default => :spec