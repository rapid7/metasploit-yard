require 'active_support/core_ext/integer/time'
require 'aruba/cucumber'

require 'metasploit/yard'

Before do
  @aruba_timeout_seconds = 10.minutes
end