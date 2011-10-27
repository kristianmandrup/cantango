module CanTango
  class Configuration
    class Models
      class Mongoid < Generic
       def models
          MongoidModels.all
        end
      end
    end
  end
end


