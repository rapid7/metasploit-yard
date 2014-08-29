# Metasploit::Yard [![Build Status](https://travis-ci.org/rapid7/metasploit-yard.svg?branch=master)](https://travis-ci.org/rapid7/metasploit-yard)[![Code Climate](https://codeclimate.com/github/rapid7/metasploit-yard.png)](https://codeclimate.com/github/rapid7/metasploit-yard)[![Test Coverage](https://codeclimate.com/github/rapid7/metasploit-yard/badges/coverage.svg)](https://codeclimate.com/github/rapid7/metasploit-yard)[![Coverage Status](https://img.shields.io/coveralls/rapid7/metasploit-yard.svg)](https://coveralls.io/r/rapid7/metasploit-yard)[![Dependency Status](https://gemnasium.com/rapid7/metasploit-yard.svg)](https://gemnasium.com/rapid7/metasploit-yard)[![Gem Version](https://badge.fury.io/rb/metasploit-yard.svg)](http://badge.fury.io/rb/metasploit-yard)[![Inline docs](http://inch-ci.org/github/rapid7/metasploit-yard.svg?branch=master)](http://inch-ci.org/github/rapid7/metasploit-yard)[![PullReview stats](https://www.pullreview.com/github/rapid7/metasploit-yard/badges/master.svg)](https://www.pullreview.com/github/rapid7/metasploit-yard/reviews/master)

`metasploit-yard` holds the YARD rake task, in [`lib/tasks/yard.rake`](lib/tasks.yard.rake) used across all
`metasploit-*` projects.  The rake task is defined here to prevent code duplication and task redefinitions in a gem's
dependencies leading to duplicate task actions, which led to yard docs being generated up to 6 times in some projects.

## Versioning

`Metasploit::Yard` is versioned using [semantic versioning 2.0](http://semver.org/spec/v2.0.0.html).  Each branch
should set `Metasploit::Yard::Version::PRERELEASE` to the branch name, while master should have no `PRERELEASE`
and the `PRERELEASE` section of `Metasploit::Yard::VERSION` does not exist.

## Documentation

`Metasploit::Yard` is documented using YARD.  In fact, it uses the same rake task as it exports for other gems to use.

### Generate

   rake yard
   
### Reading

   open doc/frames.html

## Installation

### Project with only a Gemfile

Add this line to your application's `Gemfile`:

    gem 'metasploit-yard'    

And then execute:

    $ bundle

### Project with a gemspec

Add this line to your gem's gemspec:

    spec.add_development_dependency 'metasploit-yard'

And then execute:

   $ bundle
   
### Otherwise

Or install it yourself as:

    $ gem install metasploit-yard
    
### Rakefile

Add the following to your `Rakefile` to load `yard.rake` from `metasploit-yard`

    gem_specification = Gem::Specification.find_by_name('metasploit-yard')

    Dir[File.join(gem_specification.gem_dir, 'lib', 'tasks', '**', '*.rake')].each do |rake|
      load rake
    end

## Usage

    $ rake yard

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## Testing

`Metasploit::Yard` is tested using [RSpec](https://github.com/rspec/rspec)

### Dependencies

Remove your `Gemfile.lock` so you test with the latest compatible dependencies as will be done on
[travis-ci](https://travis-ci.org/rapid7/metasploit-yard)

    rm Gemfile.lock
    bundle install

### Database Setup

To run the specs, access to the database is required, so setup the `database.yml`, create the database, and run the
migrations:

    cp spec/dummy/config/database.yml.example spec/dummy/config/database.yml
    # fill in passwords
    edit spec/dummy/config/database.yml
    rake db:create db:migrate

### Running

    rake spec
