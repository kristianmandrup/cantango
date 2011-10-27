module CanTango
  class Configuration
    class Models
      class DataMapper < Generic
        def models
          DataMapper::Resource.descendants
        end
      end
    end
  end
end

