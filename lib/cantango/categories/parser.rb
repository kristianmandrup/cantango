module CanTango
  class PermissionEngine < Engine
    module Parser
      class Categories

        def parse categories, key, obj, &blk
          case obj
          when Array
            categories[key] = obj
          else
            raise "Each key must have a YAML hash that defines which models make up the category (related kinds of items)"
          end
          yield categories if blk
        end
      end
    end
  end
end
