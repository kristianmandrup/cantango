class Admin < User 
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # INHERITED, specialize for admin if necessary

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  tango_user # see macros 
end

