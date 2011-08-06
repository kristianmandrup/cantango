module CanTango
  class Configuration
    class Engines
      class Engine
        def set state = :on
          raise ArgumentError, "Must be :on or :off" unless !state || [:on, :off].include?(state)
          @state = state || :on
        end

        [:on, :off].each do |state|
          class_eval %{
            def #{state}?
              @state == :#{state}
            end
          }
        end

        protected

        def ns
          CanTango::Configuration::Engines
        end
      end
    end
  end
end

