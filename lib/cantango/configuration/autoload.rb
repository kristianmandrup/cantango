module CanTango
  class Configuration
    class Autoload
      include Singleton

      def clear!
        @models = :on
        @permits = :on
      end

      [:models, :permits].each do |name|
        # def permission state = nil
        #   raise ArgumentError unless [:on, :off].include? state
        #   @permission = state
        # end
        class_eval %{
          def #{name} state = nil
            return #{name}? if !state
            raise ArgumentError, "Must be :on or :off" unless [:on, :off].include? state
            @#{name} = state
          end
        }
         # def permits?
        #   @permits ||= :on
        #   @permits == :on
        # end
        class_eval %{
          def #{name}?
            @#{name} ||= :on
            @#{name} == :on
          end
        }
      end
    end
  end
end


