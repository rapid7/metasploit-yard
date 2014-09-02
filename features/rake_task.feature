@gemset
Feature: yard.rake

  In order to generate documentation for metasploit projects, but not end up with multiple actions for the `yard` rake tasks
  As a developer calling `rake yard`
  I want `yard.rake` loaded from `metasploit-yard`

  Scenario: Without rails
    Given I create a clean gemset "without_rails_use_metasploit_yard"
    And I use gemset "without_rails_use_metasploit_yard"
    And I successfully run `bundle gem without_rails_use_metasploit_yard`
    And I cd to "without_rails_use_metasploit_yard"
    And I overwrite "without_rails_use_metasploit_yard.gemspec" with:
      """
      # coding: utf-8
      lib = File.expand_path('../lib', __FILE__)
      $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
      require 'without_rails_use_metasploit_yard/version'

      Gem::Specification.new do |spec|
        spec.name          = 'without_rails_use_metasploit_yard'
        spec.version       = WithoutRailsUseMetasploitYard::VERSION
        spec.authors       = ['Luke Imhoff']
        spec.email         = ['luke_imhoff@rapid7.com']
        spec.summary       = 'Uses metasploit-yard without Rails'
        spec.license       = 'MIT'

        spec.files         = `git ls-files -z`.split("\x0")
        spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
        spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
        spec.require_paths = ['lib']

        spec.add_development_dependency 'bundler'
        spec.add_development_dependency 'rake'
        spec.add_development_dependency 'metasploit-yard'
      end
      """
    And I append to "Rakefile" with:
      """
      # Use find_all_by_name instead of find_by_name as find_all_by_name will return pre-release versions
      gem_specification = Gem::Specification.find_all_by_name('metasploit-yard').first

      Dir[File.join(gem_specification.gem_dir, 'lib', 'tasks', '**', '*.rake')].each do |rake|
        load rake
      end
      """
    And I install the project gem locally
    And I successfully run `bundle install`
    When I successfully run `rake yard`
    Then the output should contain:
      """
      Undocumented Objects:
      WithoutRailsUseMetasploitYard              (lib/without_rails_use_metasploit_yard.rb:3)
      WithoutRailsUseMetasploitYard::VERSION     (lib/without_rails_use_metasploit_yard/version.rb:2)
      """
