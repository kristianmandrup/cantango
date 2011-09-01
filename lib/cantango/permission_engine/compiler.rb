module CanTango
  class PermissionEngine < Engine
    class Compiler
      attr_reader :permission, :categories

      def initialize
      end

      def compile! permission
        @permission = permission
        self
      end

      def to_hashie
        Hashie::Mash.new(eval_statements)
      end

      def eval_statements
        {:can => can_eval, :cannot => cannot_eval}
      end

      def can_eval &block
        build_statements :can, &block
      end

      def cannot_eval &block
        build_statements :cannot, &block
      end

      protected

      # build the 'can' or 'cannot' statements to evaluate
      def build_statements method, &block
        return nil if !permission.static_rules.send(method)
        yield statements(method) if !statements(method).empty? && block
        statements(method)
      end

      # TODO: make cleaner!
      def check_actions method
        permission_actions = permission.static_rules.send(method).keys.to_symbols
        raise "valid actions are: #{valid_actions}" if (permission_actions - valid_actions).size > 0
      end

      def statements method
        check_actions method
        valid_actions.map do |action|
          statements_string(method, :action => action)
        end.compact.join("\n")
      end

      # returns the targets the permission rule can manage
      # Example: permission.can[:manage]
      # returns ['Article', 'Comment']
      def get_targets method, action
        permission.static_rules.send(method).send(:[], action.to_s)
      end

      # TODO can and cannot should allow for multiple actions!
      # TODO: should be refactored to more like can([:read, :write], [Article, Comment])
      # Example: can(:manage, [Article, Comment])
      def statements_string method, options = {}
       action = options[:action]
       targets = get_targets method, action
       targets ? CanTango::PermissionEngine::Statements.new(method, action, targets).to_code : nil
      end

      def valid_actions
        [:manage, :read, :update, :create, :write]
      end
    end
  end
end
 
