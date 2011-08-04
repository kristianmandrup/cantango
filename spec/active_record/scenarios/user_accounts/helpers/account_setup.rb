module AbstractAccount
  include_and_extend SimpleRoles
end

# a user account always belongs to one user, a user can have multiple accounts!
class Account < ActiveRecord::Base
  include_and_extend AbstractAccount
  belongs_to :user

end

class UserAccount < Account
  # specifics for normal user account
  tango_user_account # see macros
end

class AdminAccount < Account
  # specifics for admin user account
  tango_user_account

end

# 'belongs' to a Guest user
class GuestAccount
  include_and_extend AbstractAccount

  tango_user_account

  attr_reader :user, :role

  def self.create options
    self.new options
  end

  def initialize options = {}
    options.each_pair do |name, value|
      var = :"@#{name}"
      self.instance_variable_set(var, value)
    end
  end
end
