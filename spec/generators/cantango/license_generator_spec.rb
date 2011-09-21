require 'spec_helper'
require 'generator-spec'

require_generator :cantango => :license

RSpec::Generator.configure do |config|
  config.debug = true
  config.remove_temp_dir = true #false
  config.default_rails_root(__FILE__)
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  # :file
end


describe Cantango::Generators::LicenseGenerator  do
  use_helpers :special, :file

  setup_generator :license do
    tests CanTango::Generators::LicenseGenerator
  end

  describe "License: Profile Administration" do
    before :each do
      @generator = with_generator do |g|
        g.run_generator "profile_administration --reads all --licenses blogging".args
      end
    end

    it "should have created license files" do
      @generator.should have_license_file :profile_administration
    end
  end
end
