class Module
  def tango_user options = {}
    self.send :include, CanTango::Users::User
    self.send :include, CanTango::Users::Masquerade if options[:masquerade]
  end

  def tango_user_account options = {}
    self.send :include, CanTango::Users::UserAccount
    self.send :include, CanTango::Users::Masquerade if options[:masquerade]
  end
  alias_method :tango_account, :tango_user_account 

  def masquerader
    self.send :include, CanTango::Users::Masquerade
  end
end
