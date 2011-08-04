require 'rspec'
require 'code-spec'
require 'cantango/rspec/matchers'

RSpec.configure do |config|
  config.include RSpec::RubyContentMatchers::License
  config.include RSpec::RubyContentMatchers::LicenseClass
  config.include RSpec::RubyContentMatchers::LicenseFile  
end
