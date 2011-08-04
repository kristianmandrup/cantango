class Module
  def tango_user
    self.send :include, CanTango::Users::User
  end

  def tango_user_account
    self.send :include, CanTango::Users::UserAccount
  end
end
