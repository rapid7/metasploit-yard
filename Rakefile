require 'bundler/gem_tasks'
require 'cucumber'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = "features --format pretty"
end

RSpec::Core::RakeTask.new(:spec)

root = Pathname.new(__FILE__).parent
rake_glob = root.join('lib', 'tasks', '**', '*.rake')

Dir[rake_glob].each do |rake|
  load rake
end

task :default => :spec