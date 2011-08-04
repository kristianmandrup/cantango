module CanTango
  module PermissionEngine
    class RulesParser
      attr_reader :categories
      attr_reader :method, :action

      def initialize method, action
        @method = method
        @action = action
      end

      # parse the value of a Permission
      def parse targets
        #inspect! {}
        targets.map do |target|
          target_and_conditions = parser(target).parse
          "#{method}(:#{action}, #{target_and_conditions})"
        end.join("\n")
      end

      private

      def parser_type target
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

      def parser target
        type = parser_type target
        parser_name = "CanTango::PermissionEngine::Parser::#{type.to_s.camelize}"
        parser_class = parser_name.constantize
        parser_class.new target, categories
      end

    end
  end
end  


