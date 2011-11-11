module CanTango
  class PermissionEngine < Engine
    class Statements
      attr_reader :method, :action

      def initialize method, action, targets
        @method = method
        @action = action
        @targets = targets
      end

      def to_code
        parse_statements.join("\n")
      end

      protected

      def parse_statements
        targets.inject([]) do |statements, target|
          statements << parser(target).parse
        end.flatten
      end

      def targets
        @targets ||= []
      end

      #def statement target_and_conditions
      #  CanTango::PermissionEngine::Statement.new method, action, target_and_conditions 
      #end

      def parser target
        CanTango::PermissionEngine::Parser.create_for method, action, target
      end
    end
  end
end
