module CanTango
  class Permit
    module ClassMethods
      def inherited(subclass)
        register permit_name(subclass), subclass
      end

      def permit_name clazz
        self.name.demodulize.gsub(/(.*)(#{clazz.to_s.camelize}Permit)/, '\1').underscore.to_sym
      end

      def type
        :abstract
      end

      def hash_key
        raise NotImplementedError
      end

      def find_permit
        finder.get_permit
      end

      def finder
        @finder ||= CanTango::PermitEngine::Finder.new permit_name(self), account_name(self)
      end

      def build_permit ability, name
        builder(ability, finder).create_permit name
      end

      def builder ability, finder
        @builder ||= CanTango::PermitEngine::Builder.new ability, finder
      end

      protected

      def register permit, subclass
        available_permits[permit] = subclass
      end

      def available_permits
        CanTango.config.permits.available_permits
      end
    end
  end
end

