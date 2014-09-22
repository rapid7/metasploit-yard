#
# Gems
#

require 'active_support/dependencies/autoload'

# Helpers for aruba step definitions for testing `rake yard`
module Metasploit::Yard::Aruba
  extend ActiveSupport::Autoload

  autoload :RvmEnv
end