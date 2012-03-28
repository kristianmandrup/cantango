class User < ActiveRecord::Base  
	extend FriendlyId
	
  include_and_extend SimpleRoles
 
  tango_user # see macros
  masquerader

  friendly_id :name

  has_many :articles
  has_many :comments
  has_many :posts
  has_many :accounts, :foreign_key => "account_id"
end
