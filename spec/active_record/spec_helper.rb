require 'rails'
require 'cantango'
require 'cantango/rspec/matchers'

require 'active_record'

require 'cutter'
require 'yaml'
require 'logger'
require 'database_cleaner'
require 'require_all'
require 'active_record/helper/ar_config'
require 'active_record/helper/rspec_config'
require 'active_record/helper/permits_config'
require 'active_record/helper/rails_config'

Cutter::Inspection.loud!

CanTango.configure do |config|
  config.permit_engine.set :on
end
