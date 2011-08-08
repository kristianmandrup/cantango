RSpec.configure do |config| 
  config.mock_with :mocha
    
  config.before(:suite) do
    DatabaseCleaner.strategy = :drop, {:include => ['migrations']}
    DatabaseCleaner.clean

    migrate("/../migrations")
  end

  config.before(:each) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.after(:each) do
  
  end  
end
