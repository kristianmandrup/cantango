require 'spec_helper'

describe CanTango do
  describe 'class level macros' do
    subject { CanTango }

    specify { lambda { CanTango::Cache::MonetaCache }.should raise_error }
    specify { lambda { CanTango::Ability::Cache::MonetaCache }.should raise_error }
    specify { lambda { CanTango::PermissionEngine::MonetaStore }.should raise_error }

    describe 'should run adapter for moneta' do
      before do
        subject.adapter :moneta
      end

      specify { lambda { CanTango::Cache::MonetaCache }.should_not raise_error }
      specify { lambda { CanTango::Ability::Cache::MonetaCache }.should_not raise_error }
      specify { lambda { CanTango::PermissionEngine::MonetaStore }.should_not raise_error }
    end

    specify { lambda { CanTango::Ability::Cache::Kompiler }.should raise_error }

    describe 'should run adapter for sourcify compiler' do
      before do
        subject.adapter :compiler
      end

      specify { lambda { CanTango::Ability::Cache::Kompiler }.should_not raise_error }
    end
  end
end


