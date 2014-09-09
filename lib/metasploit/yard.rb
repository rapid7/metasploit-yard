
#
# Project
#

require 'metasploit/yard/version'

# The namespace shared between all gems related to
# [Metasploit Framework](https://github.com/rapid7/metasploit-framework) and
# [Metasploit Commercial Editions](https://metasploit.com)
module Metasploit
  # Namespace for this gem.
  module Yard
    if defined?(Rails)
      require 'metasploit/yard/railtie'
    end
  end
end
