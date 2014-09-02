#
# Gems
#

require 'active_support/core_ext/hash/keys'

#
# Project
#

require 'metasploit/yard/aruba/rvm_env/variable'

class Metasploit::Yard::Aruba::RvmEnv::Unset < Metasploit::Yard::Aruba::RvmEnv::Variable
  #
  # CONSTANTS
  #

  # Matches line with format `unset <name>`
  REGEXP = /\Aunset (?<name>.*?)\Z/

  #
  # Class Methods
  #

  # Parses lines of `rvm env` output into a {Prepend} if it matches {REGEXP}
  #
  # @param line [String] a line of `rvm env` output.
  # @return [Unset] if line contains `unset`.
  # @return [nil] otherwise
  def self.parse(line)
    match = REGEXP.match(line)

    if match
      new(
          name: match[:name]
      )
    end
  end

  #
  # Instance Methods
  #

  # Unsets {Metasploit::Yard::Aruba::RvmEnv::Variable#name}.
  #
  # @param options [Hash{Symbol => Object}]
  # @option options [Metasploit::Yard::Aruba::RvmEnv::Unset] :from the old state of this variable
  # @option options [Object] :world the cucumber world instance for the current scenario
  def change(options={})
    options.assert_valid_keys(:from , :world)

    world = options.fetch(:world)
    world.unset_env(name)
  end
end