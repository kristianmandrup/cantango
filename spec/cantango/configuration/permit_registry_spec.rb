require 'spec_helper'

describe CanTango::Configuration::PermitRegistry do
  before do
    @permit_registry = CanTango::Configuration::PermitRegistry.new
  end

  it '#get_permit should respond to default permit types' do
    [:user, :account, :role, :role_group].each do |type|
      @permit_registry.get_permit(type).should_not be_nil
    end
  end

end
