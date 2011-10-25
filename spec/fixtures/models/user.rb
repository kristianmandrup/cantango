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

  def permissions
    @permissions ||= []
  end
end
