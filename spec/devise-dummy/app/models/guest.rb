require 'singleton'

class Guest
  include Singleton

  tango_user # see macros

  def role_groups_list
    []
  end

  def has_role? role
    true if role == :guest
  end

  def role
    :guest
  end

  def roles_list
    [:guest]
  end

  def initialize options = {}
    options.each_pair do |name, value|
      var = :"@#{name}"
      self.instance_variable_set(var, value) #if self.instance_variable_defined?(var)
    end
  end
end
