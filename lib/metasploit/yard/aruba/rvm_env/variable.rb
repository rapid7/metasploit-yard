#
# Gems
#

require 'active_support/core_ext/hash/keys'

#
# Project
#

require 'metasploit/yard/aruba/rvm_env'

# An environment variable in `rvm env`.
class Metasploit::Yard::Aruba::RvmEnv::Variable
  #
  # Attributes
  #

  # @!attribute name
  #   The name of variable being manipulated in `rvm env`
  #
  #   @return [String]
  attr_accessor :name

  #
  # Instance Methods
  #

  # @param attributes [Hash{Symbol=>String}]
  # @option attributes [String] :name (see #name)
  def initialize(attributes={})
    attributes.assert_valid_keys(:name)

    @name = attributes[:name]
  end

  # This variable is the same class and has the same {#name} as `other`.
  #
  # @return [true] if `other.class` is `Metasploit::Yard::Aruba::RvmEnv::Variable` and `other.name` is {#name}.
  # @return [false] otherwise
  def ==(other)
    other.class == self.class && other.name == self.name
  end
end