module CanTango
  module PermissionEngine
    module Loader
      class Permissions < Base
        attr_accessor :permissions

        def initialize file_name
          self.file_name = file_name
          load!
        end

        def load_from_hash hash
          hash.each do |type, groups|
          #puts "load_from_hash --- #{type}"
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

        CanTango::Configuration.permission_types.each do |type|
          define_method(:"#{type}_permissions") {
            permissions.send(:"#{type}")
          }

          define_method(:"#{type}_compiled_permissions") {
            compiled_sum = send(:"#{type}_permissions").inject({}) do |compiled_sum, (actor, permission)|
              compiled_sum.merge(permission.to_compiled_hash)
            end
            Hashie::Mash.new(compiled_sum)
          }

        end

        include ClassMethods
      
      end
    end
  end
end
