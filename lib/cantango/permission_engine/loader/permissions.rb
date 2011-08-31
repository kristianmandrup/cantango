module CanTango
  class PermissionEngine < Engine
    module Loader
      class Permissions < Base
        attr_accessor :permissions

        def initialize file_name
          self.file_name = file_name
          load!
        end

        def load_from_hash hash
          return if hash.empty?
          hash.each do |type, groups|
            groups.each do |group, rules|
              permissions[type] ||= {}
              parser.parse(group, rules) do |permission|
                permissions[type][permission.name] = permission
              end
            end
          end
        rescue => e
          raise "PermissionsLoader Error: The permissions for the file #{file_name} could not be loaded - cause was #{e}"
        end

        def load!
          return if yml_content.empty?
          yml_content.each do |type, groups|
            (permissions[type] = {} # This is for having fx empty users: section 
             next) if groups.nil?   #
            groups.each do |group, rules|
              permissions[type] ||= {}
              parser.parse(group, rules) do |permission|
                permissions[type][permission.name] = permission
              end
            end
          end
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

        include ClassMethods
      end
    end
  end
end
