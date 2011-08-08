RSpec.configure do |config|
  config.mock_with :mocha

  config.before(:suite) do

    puts "Drop all tables"
    DatabaseCleaner.drop_tables
    DatabaseCleaner::ActiveRecord.config_file_location = 'db/database.yml'

    migrate("/../migrations")

    DatabaseCleaner.strategy = :transaction
    # DatabaseCleaner.clean_with(:truncation)
    # DatabaseCleaner.clean
  end

  config.before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:each) do
  end
end
