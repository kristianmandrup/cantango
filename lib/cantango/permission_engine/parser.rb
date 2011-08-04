module CanTango
  module PermissionEngine
    module Parser
      autoload_modules :Categories, :Permissions
      autoload_modules :Category, :Default, :Ownership, :Relationship, :Rule

      def self.create_for target
        type = parser_type target
        parser_name = "CanTango::PermissionEngine::Parser::#{type.to_s.camelize}"
        parser_class = parser_name.constantize
        parser_class.new target #, categories
      end

      protected

      def self.parser_type target
        case target.to_s
        when /^\^(\w+)/ # a category is prefixed with a '@'
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
