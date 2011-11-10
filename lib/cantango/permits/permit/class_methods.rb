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

        def register permit, subclass
          available_permits[permit] = subclass
        end

        def available_permits
          CanTango.config.permits.available_permits
        end
      end
    end
  end
end

