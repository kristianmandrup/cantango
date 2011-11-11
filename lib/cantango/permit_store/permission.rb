module CanTango
  class PermissionEngine < Engine
    class Permission
      # rules is a Hashie, a Hash where keys can also be accessed as method calls
      attr_accessor :name, :static_rules, :compiled_rules

      def initialize name
        @name = name
        @static_rules = Hashie::Mash.new
        @compiled_rules = Hashie::Mash.new
      end

      def key
        name.to_s
      end

      def to_hash
        {key => static_rules.to_hash}
      end

      def to_compiled_hash
        {key => compiled_rules}
      end

      def compiled_rules
        compile_rules!
        @compiled_rules
      end

      def compile_rules!
        compiler.compile! self
        @compiled_rules = compiler.to_hashie
      end

      def compiler
        @compiler ||= CanTango::PermissionEngine::Compiler.new
      end
    end
  end
end
