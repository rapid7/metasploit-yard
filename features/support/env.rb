require 'active_support/core_ext/integer/time'
require 'aruba/cucumber'

Before do
  @aruba_timeout_seconds = 2.minutes
end