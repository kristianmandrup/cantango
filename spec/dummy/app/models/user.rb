class User < ActiveRecord::Base  
  include_and_extend SimpleRoles
 
  tango_user # see macros
  masquerader

  has_friendly_id :name

  has_many :articles
  has_many :comments
  has_many :posts
  has_many :accounts, :foreign_key => "account_id"
end
