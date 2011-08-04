class User < ActiveRecord::Base  
  include_and_extend SimpleRoles
  
  has_many :articles
  has_many :comments
  has_many :posts
  has_many :accounts, :foreign_key => "account_id"
end

# should not inherit from AR, since no need to persist Guest 
class Guest
  # ???
end
