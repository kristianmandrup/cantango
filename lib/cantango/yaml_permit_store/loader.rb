module CanTango
  class YamlPermitStore
    class Loader < ::CanTango::YamlLoader
      attr_accessor :permissions

      def initialize file_name
        @file_name = file_name
        load!
      end

      def load_from_hash hash
        return if hash.empty?
        hash.each do |type, groups|
          permissions[type] ||= {}

          next if groups.nil?

          groups.each do |group, rules|
            parser.parse(group, rules) do |permission|
              permissions[type][permission.name] = permission
            end
          end
        end
      end

      def load!
        load_from_hash yml_content
      rescue => e
        raise "PermissionsLoader Error: The permissions for the file #{file_name} could not be loaded - cause was #{e}"
      end

      def permissions
        @permissions ||= Hashie::Mash.new
      end

      def parser
        @parser ||= CanTango::PermissionEngine::Parser::Permissions.new
      end

      CanTango.config.permission_engine.types.each do |type|
        define_method(:"#{type}_permissions") {
          permissions.send(:"#{type}")
        }

        define_method(:"#{type}_compiled_permissions") do
          type_permissions = send(:"#{type}_permissions")

          return Hashie::Mash.new if !type_permissions || type_permissions.empty?

          compiled_sum = send(:"#{type}_permissions").inject({}) do |compiled_sum, (actor, permission)|
            compiled_sum.merge(permission.to_compiled_hash)
          end

          Hashie::Mash.new(compiled_sum)
        end
      end
    end
  end
end
