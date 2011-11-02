module CanTango
  class Configuration
    class Models
      class Actions
        attr_reader :collection, :member

        def initialize
          @collection = []
          @member = []
        end

        def actions_for type
          send(type.to_sym) || []
        end

        def add_member action
          @member << action.to_sym
        end

        def add_collection action
          @collection << action.to_sym
        end
      end
    end
  end
end
