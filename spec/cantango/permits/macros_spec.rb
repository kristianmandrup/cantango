require 'spec_helper'

class AdminyPermit
end

class AdminyRolePermit
end


class MyAdminyPermit < CanTango::UserPermit
end
=begin
describe '#tango_permit macro' do
  specify do
    lambda { AdminPermit.tango_permit }.should raise_error
  end

  describe 'tango permit - hash only' do
    specify do
      lambda { AdminyRolePermit.tango_permit :type => :role }.should_not raise_error
    end
    subject { AdminyRolePermit.tango_permit :type => :role }

    specify { subject[:name].should == :adminy }
    specify { subject[:type].should == :role }
    specify { subject[:account].should == nil }
  end

  describe 'Inherit from tango permit' do
    specify do
      lambda { MyAdminyPermit.tango_permit }.should_not raise_error
    end
    subject { MyAdminyPermit.tango_permit }

    specify { subject[:name].should == :my }
    specify { subject[:type].should == :user_type }
    specify { subject[:account].should == nil }
  end
end

=end
