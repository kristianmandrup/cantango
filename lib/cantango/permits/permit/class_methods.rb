module CanTango
  module Permits
    class Permit
      module ClassMethods
        def first_name clazz
          clazz.to_s.gsub(/^([A-Za-z]+).*/, '\1').underscore.to_sym # first part of class name
        end

        def type
          :abstract
        end

        def account_name clazz
          return nil if clazz.name == clazz.name.demodulize
          clazz.name.gsub(/::.*/,'').gsub(/(.*)Permits/, '\1').underscore.to_sym
        end

        def hash_key
          nil
        end
      end
    end
  end
end

