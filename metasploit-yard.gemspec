# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metasploit/yard/version'

Gem::Specification.new do |spec|
  spec.name          = "metasploit-yard"
  spec.version       = Metasploit::Yard::VERSION
  spec.authors       = ["Luke Imhoff"]
  spec.email         = ["luke_imhoff@rapid7.com"]
  spec.summary       = "yard rake tasks"
  spec.description   = "YARD rake tasks used through the metasploit-* gem namespace"
  spec.homepage      = "https://github.com/rapid7/"
  spec.license       = "BSD-3-Clause"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.1'

  # assert_valid_keys
  spec.add_development_dependency 'activesupport', '~> 4.2.6'
  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'bundler'
  # spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov'

  spec.add_runtime_dependency 'rake'

  if RUBY_PLATFORM =~ /java/
    # markdown library for YARD to enable proper parsing of README.md and CONTRIBUTING.md
    spec.add_runtime_dependency 'kramdown'

    # Cannot use Gem::Platform::JAVA as it is only defined by bundler, so `gem build *.gemspec` wouldn't work.
    spec.platform = Gem::Platform.new('java')
  else
    # markdown library for YARD to enable proper parsing of README.md and CONTRIBUTING.md
    spec.add_runtime_dependency 'redcarpet'

    spec.platform = Gem::Platform::RUBY
  end

  spec.add_runtime_dependency 'yard'
end
