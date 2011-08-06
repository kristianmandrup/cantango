require 'require_all'
require 'rspec'
require 'cancan/matchers'
require 'cantango'
require 'cantango/rspec'
require 'factory_girl'
require 'mocha'
require 'factories'

require 'cutter'

# require 'moneta'

#Cutter::Inspection.quiet!

require 'simple_roles'

CanTango.configure do |config|
  config.permissions.config_path File.dirname(__FILE__) + '/fixtures/config'
  config.cache.set :off
end
#require_all File.dirname(__FILE__) + '/fixtures'
