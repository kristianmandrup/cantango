module CanTango
  class Configuration
    class Models
      class Mongo
        def available_models
          models.map {|m| m.to_s.camelize }
        end
      end
    end
  end
end

