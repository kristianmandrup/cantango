module CanTango
  class Configuration
    class UserAccount
      include Singleton
      include ClassExt

      def clear!
        @clazz = nil
      end

      def base_class
        @clazz ||= (::UserAccount if defined? ::UserAccount)
      end

      def base_class= clazz
        raise ArgumentError, "Must be a class, was: #{clazz}" unless is_class? clazz
        @clazz = clazz
      end
    end
  end
end


