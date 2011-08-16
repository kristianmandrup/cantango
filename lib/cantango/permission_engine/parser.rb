module CanTango
  class PermissionEngine < Engine
    module Parser
      autoload_modules :Categories, :Permissions
      autoload_modules :Category, :Default, :Ownership, :Relationship, :Regex, :Rule

      def self.create_for method, action, target
        type = parser_type target
        parser_name = "CanTango::PermissionEngine::Parser::#{type.to_s.camelize}"
        parser_class = parser_name.constantize
        parser_class.new method, action, target
      end

      protected

      def self.parser_type target
        case target.to_s
        when /\/(.*)\//
          :regex
        when /^\^(\w+)/ # a category is prefixed with a '^<D-^>s'
          :category
        when /\w+#\w+=.+/
          :relationship
        when /\w+#\w+/
          :ownership
        else
          :default
        end
      end
    end
  end
end
