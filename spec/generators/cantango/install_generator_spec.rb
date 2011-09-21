require 'spec_helper'
require 'generator-spec'

# require 'generators/cantango/install/install_generator'

require_generator :cantango => :install

RSpec::Generator.configure do |config|
  config.debug = true
  config.remove_temp_dir = false
  config.default_rails_root(__FILE__)
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  # :file
end


describe Cantango::Generators::InstallGenerator do
  use_helpers :special, :file

  setup_generator :permit do
    tests Cantango::Generators::InstallGenerator
  end

  describe 'Run Install generator' do
    before :each do
      @gen_result = with_generator do |g|
        g.run_generator
      end
    end

    describe 'result of running Install generator' do
      it "should create config files" do
        @gen_result.should have_initializer_file :cantango do |file|
          file.should have_content /engines/
        end
        @gen_result.should have_config_file :categories
        @gen_result.should have_config_file :permissions
      end
    end
  end
end

