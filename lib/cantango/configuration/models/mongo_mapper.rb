module CanTango
  class Configuration
    class Models
      module MongoMapper < Mongo
        def models
          MongoMapper.database.collections
        end
      end
    end
  end
end
