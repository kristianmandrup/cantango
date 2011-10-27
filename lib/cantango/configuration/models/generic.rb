module CanTango
  class Configuration
    class Models
      class Generic
        def available_models
          models.map(&:name)
        end
      end
    end
  end
end

