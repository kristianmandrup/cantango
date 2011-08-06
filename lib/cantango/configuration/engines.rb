require 'singleton'

module CanTango
  class Configuration
    class Engines
      autoload_modules :Permission, :Permit, :Cache

      include Singleton

      def self.available
        [:permit, :permission, :cache]
      end

      def available? name
        self.class.available.include? name.to_sym
      end

      available.each do |engine|
        # def permission?
        #   @permission ||= :on
        #   @permission == :on
        # end
        class_eval %{
          def #{engine}?
            @#{engine} ||= :on
            @#{engine} == :on
          end
        }

        # def permission state = nil
        #   return Permission.instance if !state
        #   raise ArgumentError unless [:on, :off].include? state
        #   @permission = state
        # end
        class_eval %{
          def #{engine} state = nil
            return #{engine.to_s.camelize}.instance if !state
            raise ArgumentError, "Must be :on or :off" unless [:on, :off].include? state
            @#{engine} = state
          end
        }
      end
    end
  end
end


