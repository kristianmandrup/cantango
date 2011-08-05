require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration do
  subject { CanTango::Configuration }
  it "should" do
    puts CanTango::Configuration.roles
  end
    
    its(:roles)               { should_not be_empty }
    its(:role_groups)         { should == [] }
    its(:user_relationships)  { should_not be_empty }
    its(:special_permits)     { should_not be_empty }

    it "should turn on/off engines" do
      CanTango::Configuration.engines.permission?.should be_false
      CanTango::Configuration.engines.permit?.should be_true

      CanTango::Configuration.engines.permission :off
      CanTango::Configuration.engines.permission?.should be_false

      CanTango::Configuration.engines.permit :off
      CanTango::Configuration.engines.permit?.should be_false

      CanTango::Configuration.engines.permission :on
      CanTango::Configuration.engines.permission?.should be_true

      CanTango::Configuration.engines.permit :on
      CanTango::Configuration.engines.permit?.should be_true
    end

  context "CanTango#configure DSL" do
    before(:all) {
      CanTango.configure do |config|
        config.engines.permission :off
        config.engines.permit :off
      end
    }

    specify { CanTango::Configuration.engines.permit?.should be_false}
    specify { CanTango::Configuration.engines.permission?.should be_false}
  end
end
