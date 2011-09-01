require 'spec_helper'

describe CanTango::Configuration::Permits do
  before do
    @permit_registry = CanTango::Configuration::Permits.instance
  end

  it "should respond to permits groups methods" do
    [:user, :account, :role, :role_group].each do |permit_group|
      @permit_registry.should respond_to(permit_group)
    end
  end

  it "should treat missing methods as account keys" do
    @permit_registry.any_method.should be_kind_of(CanTango::Configuration::PermitRegistry)
  end

  context "account keys" do
    it "should behave like PermitRegistry" do
      [:user, :account, :role, :role_group].each do |permit_group|
        @permit_registry.admin_account.should respond_to(permit_group) 
      end
    end
  end
end
