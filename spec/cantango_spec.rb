require 'spec_helper'

describe CanTango do
  describe 'class level macros' do
    subject { CanTango }

    specify { lambda { CanTango::Cache::MonetaCache }.should raise_error }
    specify { lambda { CanTango::Ability::Cache::MonetaCache }.should raise_error }
    specify { lambda { CanTango::PermissionEngine::MonetaStore }.should raise_error }
    
    describe 'permits allowed/denied' do
      specify { lambda { subject.permits_allowed }.should raise_error }
      specify { lambda { subject.permits_denied }.should raise_error }
    end

    [:config, :configure].each do |name|
      specify { subject.send(name).should be_a CanTango::Configuration }
    end
    
    describe 'clear_permits_executed!' do
      specify { CanTango.config.permits.executed.should be_empty }
      
      before do
        CanTango.config.permits.executed[:x] = 1
        subject.clear_permits_executed!
      end
      
      specify { CanTango.config.permits.executed.should be_empty }
    end
  end
end