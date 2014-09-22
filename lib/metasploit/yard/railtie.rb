module Metasploit
  module Yard
    # Automatically loads `yard.rake` for any Rails project.
    class Railtie < Rails::Railtie
      rake_tasks do
        load 'tasks/yard.rake'
      end
    end
  end
end