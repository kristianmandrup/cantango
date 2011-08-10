require 'spec_helper'
require 'rails'
require 'active_record'
require 'arel'
require 'meta_where'
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
  config.permits.set :on
end
