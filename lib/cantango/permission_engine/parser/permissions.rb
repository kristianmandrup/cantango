module CanTango
  class PermissionEngine < Engine
    module Parser
      class Permissions

        def initialize
        end

        def parse(key, obj, &blk)
          permission = CanTango::PermissionEngine::Permission.new key
          case obj
          when Hash
            parse_permission(obj, permission, &blk)
          else
            raise "Each key must have a YAML hash that defines its permission configuration"
          end
          yield permission if blk
        end

        protected

        # set :can and :cannot on permission with the permission rule
        def parse_permission(obj, permission, &blk)
          # Forget keys because I don't know what to do with them
          obj.each do |key, value|
            raise ArgumentError, "A CanTango permissions .yml file can only have the keys can: and cannot:" if ![:can, :cannot].include?(key.to_sym)
            permission.static_rules.send :"#{key}=", value
          end
        end
      end
    end
  end
end
