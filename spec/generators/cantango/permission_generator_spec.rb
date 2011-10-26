require 'spec_helper'
require 'generator-spec'

require_generator :cantango => :permission

RSpec::Generator.configure do |config|
  config.debug = true
  config.remove_temp_dir = true #false
  config.default_rails_root(__FILE__)
  config.lib = File.dirname(__FILE__) + '/../lib'
  config.logger = :stdout  # :file
end


describe Cantango::Generators::PermissionGenerator do
  use_helpers :model, :special, :file

  setup_generator :permission do
    tests Cantango::Generators::PermissionGenerator
  end

  describe 'Run Permission generator' do
    before :each do
      @generator = with_generator do |g|
        g.run_generator ["user"]
      end
    end

    describe 'result of running Permission generator' do
      it "should create Permission model for user" do
        @generator.should have_model :permission do |model|
          # model.should match /belongs_to :user/
        end
      end

      it "should add has_many :permissions on User model" do
        @generator.should have_model :user do |model|
          # model.should match /has_many :permissions/
        end
      end
    end
  end
end

