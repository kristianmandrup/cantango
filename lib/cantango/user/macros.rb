module CanTango::User
  module Macros
    def tango_user options = {}
      self.send :include, CanTango::User
      self.send :include, CanTango::User::Macros::Masquerader
      masquerader if options[:masquerade]
    end
    alias_method :cantango_user, :tango_user

    module Masquerader
      def masquerader
        self.send :include, CanTango::User::Masquerade
      end
    end
  end
end