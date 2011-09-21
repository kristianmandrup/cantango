require 'spec_helper'
require 'generator-spec'

require_generator :cantango => :role_permits

RSpec::Generator.configure do |config|
  config.debug = true
  config.remove_temp_dir = true #false
  config.default_rails_root(__FILE__) 
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  # :file
end


describe Cantango::Generators::RolePermitsGenerator do
  use_helpers :controller, :special, :file
    setup_generator :permits do
    tests Cantango::Generators::RolePermitsGenerator
  end

  describe 'result of running generator with default profile' do
    before :each do
      @generator = with_generator do |g|
        g.run_generator "--orm mongoid".args
      end
    end

    describe 'result of running Permits generator' do
      it "should create Admin permit" do
        @generator.should generate_permit :admin
      end

      it "should generate a permits initializer file with orm set to mongoid" do
        File.read(initializer_file(:permits)).should match /config.orm = :mongoid/
      end
    end
  end

  describe 'result of running generator with option to create permit for each registered role' do
    context "Registered roles :editor, :admin" do
      before :each do
        @generator = with_generator do |g|
          g.run_generator "admin editor".args
        end
      end

      it "should have created Guest and Admin permits" do
        @generator.should have_permit_files :guest, :admin
      end

      it "should have created the Editor permit for the :editor role and the permit should not use licenses" do      
        @generator.should have_permit_file :editor do |editor_permit|
          editor_permit.should_not have_licenses :user_admin, :blogging 
        end
      end
    end #ctx
  end
end
