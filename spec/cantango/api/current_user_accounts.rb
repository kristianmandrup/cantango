require 'cantango/api/current_users'

module CurrentUserAccounts
  include CurrentUsers 

  def current_user_account
    ::UserAccount.new(current_user, :roles => [:user])
  end
  
  def current_admin_account
    ::UserAccount.new(current_admin, :roles => [:admin])
  end
end

