module RSpec
  module RubyContentMatchers
    autoload :License,       'cantango/rspec/matchers/have_license'
    autoload :LicenseClass,  'cantango/rspec/matchers/have_license_class'
    autoload :LicenseFile,   'cantango/rspec/matchers/have_license_file'
  end
end

require 'cantango/rspec/matchers/be_allowed_to'
