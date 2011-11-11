module CanTango
  class Permit
    module  Naming
      def permit_type_name clazz
        clazz.name.demodulize.sub(/Permit$/, '').underscore.to_sym
      end

      def account_name clazz
        return nil if clazz.name == clazz.name.demodulize
        clazz.name.gsub(/::.*/,'').gsub(/(.*)Permits/, '\1').underscore.to_sym
      end

      protected

      def first_name clazz
        clazz.to_s.gsub(/^([A-Za-z]+).*/, '\1').underscore.to_sym # first part of class name
      end
    end
  end
end
