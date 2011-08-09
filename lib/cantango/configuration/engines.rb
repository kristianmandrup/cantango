require 'singleton'

module CanTango
  class Configuration
    class Engines
      autoload_modules :Permission, :Permit, :Cache, :Store, :Engine

      include Singleton

      # engines available
      def self.available
        [:permit, :permission, :cache]
      end

      def available
        self.class.available
      end

      def available? name
        self.class.available.include? name.to_sym
      end

      available.each do |engine|
        # def permission
        #   return Permission.instance
        # end
        class_eval %{
          def #{engine}
            #{engine.to_s.camelize}.instance
         end
        }
      end
    end
  end
end


