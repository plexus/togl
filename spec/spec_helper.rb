require 'bogus/rspec'
require 'timeout'
require 'togl'

RSpec.configure do |rspec|
  rspec.backtrace_exclusion_patterns = [] if ENV['FULLSTACK']
  rspec.disable_monkey_patching!
  rspec.raise_errors_for_deprecations!
  # rspec.around(:each) do |example|
  #   Timeout.timeout(1, &example)
  # end
end

Bogus.configure do |bogus|
  bogus.search_modules << Togl
end
