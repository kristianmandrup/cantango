module CanTango::PermissionEngine
  class Statements
    attr_reader :method, :action

    def initialize method, action, targets
      @method = method
      @action = action
      @targets = targets
    end

    def to_code
      parse_statements.map(&:to_code).join("\n")
    end

    protected

    def parse_statements
      targets.inject([]) do |statements, target|
        target_and_conditions = parser(target).parse
        statements << statement(target_and_conditions)
      end
    end

    def targets
      @targets ||= []
    end

    def statement target_and_conditions
      CanTango::PermissionEngine::Statement.new method, action, target_and_conditions 
    end

    def parser target
      CanTango::PermissionEngine::Parser.create_for target
    end
  end
end
