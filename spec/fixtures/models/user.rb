require 'fixtures/models/simple_roles'

class User
  attr_accessor :name, :account, :email

  # tango_user # see macros

  include ::SimpleRoles

  def initialize name, email = nil, options = {}
    @name = name
    @email = email
    set_option_vars options
  end

  def set_option_vars options = {}
    options.each_pair do |name, value|
      var = :"@#{name}"
      self.instance_variable_set(var, value)
    end
  end

  def email
    @email ||= 'default@gmail.com'
  end

  def role
    @role || ''
  end

  # This hash should be recalculated anytime the permissions collection changes
  #

  # after_update :recalculate_permissions_hash

  def permissions_hash
    @permissions_hash = permissions.hash
  end

  def permissions
    @permissions ||= []
  end

  # allows implementation specific to ORM, fx using #all on some datastores such as Mongoid etc.
  alias_method :all_permissions, :permissions

  protected

  def recalculate_permissions_hash
    @permissions_hash = nil if self.permissions_changed?
  end
end
