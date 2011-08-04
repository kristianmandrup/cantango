module CanTango
  module PermissionEngine
    module Parser
      class Categories

        def parse category_config, key, obj, &blk
          case obj
          when Array
            category_config.categories[key] = obj
          else
            raise "Each key must have a YAML hash that defines which models make up the category (related kinds of items)"
          end
          yield category_config if blk
        end
      end
    end
  end
end
