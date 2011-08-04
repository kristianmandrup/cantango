require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration do
  subject { CanTango::Configuration }
    its(:roles)               { should_not be_empty }
    its(:role_groups)         { should_not be_empty }
    its(:user_relationships)  { should_not be_empty }
    its(:special_permits)     { should_not be_empty }

    it "should turn on/off engines" do
      CanTango::Configuration.permission_engine?.should be_false
      CanTango::Configuration.permit_engine?.should be_true

      CanTango::Configuration.permission_engine :off
      CanTango::Configuration.permission_engine?.should be_false

      CanTango::Configuration.permit_engine :off
      CanTango::Configuration.permit_engine?.should be_false

      CanTango::Configuration.permission_engine :on
      CanTango::Configuration.permission_engine?.should be_true

      CanTango::Configuration.permit_engine :on
      CanTango::Configuration.permit_engine?.should be_true
    end

  context "CanTango#configure DSL" do
    before(:all) { 
      CanTango.configure do |config|
        config.permission_engine :off
        config.permit_engine :off
      end
    }

    specify { CanTango::Configuration.permit_engine?.should be_false}
    specify { CanTango::Configuration.permission_engine?.should be_false}
  end
end
