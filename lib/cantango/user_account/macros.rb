module CanTango::UserAccount
  module Macros
    def tango_user_account options = {}
      self.send :include, CanTango::UserAccount
      self.send :include, CanTango::UserAccount::Macros::Masquerader
      masquerader if options[:masquerade]
    end
    alias_method :tango_account, :tango_user_account
    alias_method :cantango_account, :tango_user_account
  end
  
  module Masquerader
    def masquerader
      self.send :include, CanTango::UserAccount::Masquerade
    end
  end
end