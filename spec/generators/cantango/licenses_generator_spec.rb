require 'spec_helper'
require 'generator-spec'

require_generator :cantango => :licenses

RSpec::Generator.configure do |config|
  config.debug = true
  config.remove_temp_dir = true #false
  config.default_rails_root(__FILE__) 
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  # :file
end


describe Cantango::Generators::LicensesGenerator do
  use_helpers :controller, :special, :file

  setup_generator :licenses do
    tests Cantango::Generators::LicensesGenerator
  end

  describe "Licenses: Profile Administration and Article Editing" do
    before :each do
      @generator = with_generator do |g|
        g.run_generator "profile_administration article_editing".args
      end
    end

    it "should have created license files" do
      @generator.should have_license_files :profile_administration, :article_editing
       @generator.should_not have_license_files :blogging, :user_admin
    end
  end

  describe "Licenses: Profile Administration and Article Editing" do
    before :each do
      @generator = with_generator do |g|
        g.run_generator "profile_administration article_editing".args
      end
    end

    it "should have created license files" do
      @generator.should have_license_files :profile_administration, :article_editing, :blogging, :user_admin
    end

    it "should have created license file :profile_administration with the right class" do
      @generator.should have_license_file :profile_administration do |license|
        license.should have_license_class :profile_administration
      end
    end

    it "should have created license file :article_editing with the right class" do
      @generator.should have_license_file :article_editing do |license|
        license.should have_license_class :article_editing
      end
    end
  end
end
