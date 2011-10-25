require 'active_support/inflector'

module CanTango
  class PermitEngine < Engine
    module Util
      def permit_name clazz
        @name ||= clazz.to_s.demodulize.gsub(/Role/,'').gsub(/Permit$/, '').gsub(/Group/,'').underscore.to_sym
      end

      # TODO:
      def role
        @role ||= permit_name
      end

      def localhost_manager?
        Permits::Configuration.localhost_manager
      end
    end
  end
end

