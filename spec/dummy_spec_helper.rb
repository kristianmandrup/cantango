require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)

require 'require_all'
require 'rspec/rails'
require 'cancan/matchers'
require 'database_cleaner'
require 'cutter'
require 'capybara/rails'
require 'capybara/rspec'

#require 'cantango/rspec'
#require 'factory_girl'
#require 'mocha'
#require 'factories'
#require 'controller_macros'
#Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

ActiveRecord::Base.logger = Logger.new(STDERR)
DatabaseCleaner.strategy = :truncation
def migration_folder(name)
  migrations_path = File.dirname(__FILE__)
  name ? File.join("#{migrations_path}" "#{name}") : "#{migrations_path}/migrations"
end

def migrate(name = nil)
  mig_folder = migration_folder(name)
  ActiveRecord::Migrator.migrate mig_folder
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.before(:suite) do
    DatabaseCleaner.strategy = :drop, {:include => ['migrations']}
    DatabaseCleaner.clean
    migrate("/dummy/db/migrate")
  end
end
