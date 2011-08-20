class User < ActiveRecord::Base  
  include_and_extend SimpleRoles
 
  tango_user # see macros

  has_many :user_todos
  has_many :todos, :through => :user_todos

  has_many :articles
  has_many :comments
  has_many :posts
  has_many :accounts, :foreign_key => "account_id"
end

class Admin < User 
  tango_user # see macros
  masquerader
end

# should not inherit from AR, since no need to persist Guest 
class Guest

  tango_user # see macros  

  def email
    'guest@gmail.com'
  end

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
