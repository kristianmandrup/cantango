source :rubygems.org

group :default do
  gem 'rails',          '>= 3.0.1'
  gem 'cancan',         '>= 1.4'
  gem 'sugar-high',     '>= 0.6.0'
  gem 'sweetloader',    '~> 0.1.0'
  gem 'hashie',         '>= 0.4'

  # IMPORTANT: Each of the cantango extension gems should depend on cantango-core
  # cantango-core MUST have NO cantango related dependencies
  gem 'cantango-config',  :git => 'git://github.com/kristianmandrup/cantango-config.git'
  gem 'cantango-api',  :git => 'git://github.com/kristianmandrup/cantango-api.git'
end

group :test do
  # Specs
  gem 'spork'
  gem 'capybara'
  gem 'mocha'
  gem 'launchy'

  gem 'rspec-rails',    '>= 2.6.1'  # needed in development to expose the rails generators
end

group :development, :test do
  gem 'sqlite3'
  gem 'forgery',        '>= 0.3' # needed in development when using rake db:seed
  gem 'factory_girl'

  # Debug and performance tests
  gem 'cutter'
end

group :development do
  gem 'rspec',    '>= 2.4.0'
  gem 'jeweler',  '>= 1.6.4'
  gem 'bundler',  '>= 1.0.1'
  gem 'rdoc'
end

