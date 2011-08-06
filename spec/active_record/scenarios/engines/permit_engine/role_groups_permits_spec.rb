require 'active_record/spec_helper'
require_all File.dirname(__FILE__) + "/../../shared/" 

def preconfigure
  CanTango.configure do |config|
    config.permits.set :on
    config.permissions.set :off
  end
end

def reset_back
  CanTango.configure do |config|
    config.permits.set :on
    config.permissions.set :off
  end
end

describe 'RoleGroupPermit usage' do
  before(:each) {
    preconfigure
    @user = User.create!(:email => "kris@gmail.com", :role_groups_list => [:musicians])
  }

  after(:each) { reset_back }

  let(:current_user) { @user }
  let(:ability) { current_ability(:user) }

  it "should be allowed to read Song" do
    ability.should be_allowed_to(:read, Song)
  end
  
  it "should be allowed to write Tune" do
    ability.should be_allowed_to(:write, Tune)
  end

  it "should be allowed to manage Concerto" do
    ability.should be_allowed_to(:read, Concerto)
  end
  
  it "should be allowed to write Tune" do
    ability.should_not be_allowed_to(:manage, Improvisation)
  end
end
