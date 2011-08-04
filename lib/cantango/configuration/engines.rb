require 'singleton'

module CanTango
  class Configuration
    class Engines
      include Singleton

      [:permit, :permission, :cache].each do |engine|
        attr_accessor engine

        # def permission?
        #   @permission_engine ||= :on
        #   @permission_engine == :on
        # end
        class_eval %{
          def #{engine}?
            @#{engine} ||= :on
            @#{engine} == :on
          end
        }

        class_eval %{
          def #{engine} state
            raise ArgumentError unless [:on, :off].include? state
            @#{engine} = state
          end
        }
      end
    end
  end
end


