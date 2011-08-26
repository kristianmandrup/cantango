require 'require_all'
require 'rspec'
require 'cancan/matchers'
require 'cantango'
require 'cantango/rspec'
require 'mocha'
require 'fixtures/models'

require 'factory_girl'
FactoryGirl.find_definitions

require 'cutter'

# require 'moneta'

#Cutter::Inspection.quiet!

require 'simple_roles'

CanTango.configure do |config|
  config.permission_engine.config_path File.dirname(__FILE__) + '/fixtures/config'
  # config.cache.set :off
end
#require_all File.dirname(__FILE__) + '/fixtures'
