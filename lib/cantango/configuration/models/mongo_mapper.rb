module CanTango
  class Configuration
    class Models
      module MongoMapper < Generic
        def models
          MongoMapperModels.all
        end
      end
    end
  end
end
