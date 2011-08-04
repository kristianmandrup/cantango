# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "cantango"
  gem.homepage = "http://github.com/kristianmandrup/cantango"
  gem.license = "MIT"
  gem.summary = %Q{CanCan extension with role oriented permission management and more}
  gem.description = %Q{Define your permission rules as role- or role group specific permits.
Integrates well with multiple Devise user acounts.
Includes rules caching.
Store permissions in yaml file or key-value store}
  gem.email = "kmandrup@gmail.com, s.pankevich@gmail.com"
  gem.authors = ["Kristian Mandrup", "Stanislaw Pankevich"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "cantango #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
