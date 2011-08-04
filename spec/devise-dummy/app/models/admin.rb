class Admin < User 
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable

  # INHERITED, specialize for admin if necessary

  #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # INHERITED, specialize for admin if necessary

  # Setup accessible (or protected) attributes for your model
  # attr_accessible :email, :password, :password_confirmation, :remember_me

  tango_user # see macros 
end

