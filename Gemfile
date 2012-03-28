source 'http://rubygems.org'

group :default do
  gem 'rails',            '>= 3.0.1'
  gem 'cancan',           '>= 1.4'
  gem 'sugar-high',       '>= 0.6.0'
  gem 'sweetloader',      '~> 0.1.0'
  gem 'hashie',           '>= 0.4'

  # adapters
  # gem 'sourcify'
  # gem 'dkastner-moneta',  '>= 1.0'
  # gem 'meta_where'
  # gem 'mongoid'
end

group :test do
  gem 'require_all', '~> 1.2.0'

  # Data
  gem 'database_cleaner', :git => "git://github.com/kristianmandrup/database_cleaner.git"
  gem 'factory_girl'

  # for later...
  # gem 'meta_where'
  # gem 'mongoid'

  # Specs
  gem 'spork'
  gem 'capybara'
  gem 'rails-app-spec', '>= 0.5.0'
  gem 'mocha'
  gem "launchy"

  # Debug and performance tests
  gem 'cutter'

  # Integration testing
  gem 'decent_exposure'
  gem "friendly_id",    "~> 4.0.1"
  gem "devise",         '>= 1.4'

  # Rails
  gem 'haml'

  # Generators
  gem 'generator-spec', '>= 0.7.8'
end

group :development, :test do
  gem "rspec-rails",  '>= 2.6.1'  # needed in development to expose the rails generators
  gem 'forgery',      '>= 0.3' # needed in development when using rake db:seed
  gem 'factory_girl'
  gem 'sqlite3'

  # Adapters
  gem 'sourcify'
  gem 'dkastner-moneta',  '>= 1.0'
end

group :development do
  gem "rspec",    ">= 2.4.0"
  gem "jeweler",  ">= 1.6.4"
  gem "bundler",  ">= 1.0.1"
  gem "rdoc"

  # gem 'logging_assist'
  # gem 'meta_where'
  # gem 'mongoid'
end

