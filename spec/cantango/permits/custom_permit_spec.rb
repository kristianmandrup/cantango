# registering a custom permit
#

require 'rspec'
require 'cantango'
# require 'simple_roles'
require 'fixtures/models'
require 'cantango/rspec'

class MembershipPermit < CanTango::Permit
  class Builder
  end

  class Finder

  end

  def self.inherited(base_clazz)
    CanTango.config.permits.register_permit_class membership_name(base_clazz), base_clazz, type, account_name(base_clazz)
  end

  def self.type
    :membership
  end

  def self.membership_name clazz
    clazz.name.demodulize.gsub(/(.*)(MembershipPermit)/, '\1').underscore.to_sym
  end

  def self.hash_key
    :memberships
  end

  def permit_name
    self.class.membership_name self.class
  end
  alias_method :membership_name, :permit_name

  # creates the permit
  # @param [Permits::Ability] the ability
  # @param [Hash] the options
  def initialize ability
    super
  end

  def permit?
    super
  end

  def valid_for? subject
    subject.memberships.include? membership_name
  end
end

describe 'Custom Permit registration - Membership' do
  it 'should register :membership as available permit' do
    CanTango.config.permits.available_permits[:membership].should == MembershipPermit
  end

  it 'should register :membership as available permit type' do
    CanTango.config.permits.available_types.should include(:membership)
  end

  it 'should register MmembershipPermit as available permit class' do
    CanTango.config.permits.available_classes.should include(MembershipPermit)
  end
end

