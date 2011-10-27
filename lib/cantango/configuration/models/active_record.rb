module CanTango
  class Configuration
    class Models
      class ActiveRecord < Generic
       def models
          ActiveRecord::Base.descendants
        end
      end
    end
  end
end
