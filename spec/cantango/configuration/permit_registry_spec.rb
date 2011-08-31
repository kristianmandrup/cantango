require 'spec_helper'

describe CanTango::Configuration::PermitRegistry do
  before do
    @permit_registry = CanTango::Configuration::PermitRegistry.new
  end

  it "should respond to permits groups methods" do
    [:user, :account, :role, :role_group].each do |permit_group|
      @permit_registry.should respond_to(permit_group)
    end
  end

end
