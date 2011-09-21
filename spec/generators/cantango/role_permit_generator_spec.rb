require 'spec_helper'
require 'generator-spec'

require_generator :cantango => :role_permit

RSpec::Generator.configure do |config|
  config.debug = true
  config.remove_temp_dir = true #false
  config.default_rails_root(__FILE__)
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  # :file
end


describe Cantango::Generators::RolePermitGenerator do
  use_helpers :special, :file

  setup_generator :permit do
    tests Cantango::Generators::RolePermitGenerator
  end

  describe 'Run Permit generator' do
    before :each do
      @generator = with_generator do |g|
        g.run_generator "admin --reads all --licenses blogging user_admin".args
      end
    end

    describe 'result of running Permit generator' do
      it "should create Admin permit" do
        @generator.should generate_permit :admin
      end
    end
  end
end
