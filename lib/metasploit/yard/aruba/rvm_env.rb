#
# Gems
#

require 'active_support/dependencies/autoload'
require 'active_support/core_ext/hash/keys'

#
# Project
#

# Helpers for parsing `rvm env` output
module Metasploit::Yard::Aruba::RvmEnv
  extend ActiveSupport::Autoload

  autoload :Export
  autoload :Prepend
  autoload :Unset
  autoload :Variable

  #
  # CONSTANTS
  #

  # Class for parsing lines for `rvm env` in order of precedence
  LINE_PARSER_PRECEDENCE = [
      # must be before `Metasploit::Yard::Aruba::RvmEnv::Export` because
      # `Metasploit::Yard::Aruba::RvmEnv::Export::REGEXP` matches a superset of
      # `Metasploit::Yard::Aruba::RvmEnv::Prepend::REGEXP`
      Metasploit::Yard::Aruba::RvmEnv::Prepend,
      Metasploit::Yard::Aruba::RvmEnv::Export,
      Metasploit::Yard::Aruba::RvmEnv::Unset
  ]

  # Changes from one `rvm env [@<gemset>]` to another.
  #
  # @param options [Hash{Symbol => Array<Metasploit::Yard::Aruba::RvmEnv::Variable>}]
  # @option options :from [Array<Metasploit::Yard::Aruba::RvmEnv::Variable>] the current rvm env; usually the output of
  #   parsing `rvm env`.
  # @option options :to [Array<Metasploit::Yard::Aruba::RvmEnv::Variable>] the new rvm env; usualy the output of parsing
  #   `rvm env @<gemset>`
  # @option options [Object] :world the cucumber World instance for the current scenario.
  def self.change(options={})
    options.assert_valid_keys(:from, :to, :world)

    from_by_name = parsed_to_hash(options.fetch(:from))
    to_by_name = parsed_to_hash(options.fetch(:to))
    world = options.fetch(:world)

    to_by_name.each do |name, to_variable|
      from_variable = from_by_name[name]

      # ignore variables that didn't change
      unless to_variable == from_variable
        to_variable.change(
            from: from_variable,
            world: world
        )
      end
    end
  end

  # Parses the output of `rvm env`.
  #
  # @return [Array<Metasploit::Yard::Aruba::RvmEnv::Variable, #apply>]
  def self.parse(rvm_env)
    rvm_env.each_line.map { |line|
      parse_line(line)
    }
  end

  # Parses an individual line of `rvm env`
  #
  # @return [Metasploit::Yard::Aruba::RvmEnv::Variable, #apply]
  # @raise [ArgumentError] if no `Class` in {LINE_PARSER_PRECEDENCE} returns a parsed instance.
  def self.parse_line(line)
    parsed = nil

    LINE_PARSER_PRECEDENCE.each do |line_parser|
      parsed = line_parser.parse(line)

      if parsed
        break
      end
    end

    unless parsed
      raise ArgumentError, "No line parser could parse #{line.inspect}"
    end

    parsed
  end

  # Converts output of {parse} into Hash that maps {Metasploit::Yard::Aruba::RvmEnv::Variable#name} to the
  # {Metasploit::Yard::Aruba::RvmEnv::Variable}.
  #
  # @param parsed [Array<Metasploit::Yard::Aruba::RvmEnv::Variable>] output of {parse}.
  # @return [Hash{String => Metasploit::Yard::Aruba::RvmEnv::Variable}] Map of
  #   {Metasploit::Yard::Aruba::RvmEnv::Variable#name} to the {Metasploit::Yard::Aruba::RvmEnv::Variable}.
  def self.parsed_to_hash(parsed)
    parsed.each_with_object({}) { |variable, variable_by_name|
      variable_by_name[variable.name] = variable
    }
  end
end