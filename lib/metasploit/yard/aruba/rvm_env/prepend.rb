#
# Gems
#

require 'active_support/core_ext/hash/keys'

#
# Project
#

require 'metasploit/yard/aruba/rvm_env'

# Recognizes `export`s that are actually prepending values to the pre-existing value as is the case with `PATH`.
class Metasploit::Yard::Aruba::RvmEnv::Prepend < Metasploit::Yard::Aruba::RvmEnv::Export
  #
  # CONSTANTS
  #

  # Matches line with format `export <name>=<quote><value>$<name><quote>`.  `<value>` will contain trailing
  # `File::PATH_SEPARATOR`, so it can be directly prepended to the current value of `<name>` to get the value to set
  # the environment variable.
  REGEXP = /\Aexport (?<name>.*?)=(?<quote>"|')(?<value>.*?#{File::PATH_SEPARATOR})\$\k<name>\k<quote>\Z/

  # Replaces {Metasploit::Yard::Aruba::RvmEnv::Prepend#value `:from` value} with
  # {Metasploit::Yard::Aruba::RvmEnv::Export#value this variable's value}.
  #
  # @param options [Hash{Symbol => Object}]
  # @option options [Metasploit::Yard::Aruba::RvmEnv::Unset] :from the old state of this variable.
  # @option options [Object] :world the cucumber world instance for the current scenario
  def change(options={})
    options.assert_valid_keys(:from, :world)

    from = options.fetch(:from)
    world = options.fetch(:world)

    from_directories = from.value.split(File::PATH_SEPARATOR)
    to_directories = value.split(File::PATH_SEPARATOR)

    path = ENV[name]

    to_directories.zip(from_directories) do |to_directory, from_directory|
      path = path.gsub(from_directory, to_directory)
    end

    world.set_env(name, path)
  end
end