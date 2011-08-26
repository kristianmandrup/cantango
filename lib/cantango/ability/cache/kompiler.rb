require 'sourcify'

module CanTango
  class Ability
    class Cache
      class Kompiler
        class CacheMarshallError < StandardError; end

        def compile! rules_raw
          return if !rules_raw
          rules_compiled = rules_raw.map do |rule|
            rule.block = rule.block.to_source if rule.block.class == Proc && sourcify?
            rule
          end
        end

        def decompile! rules_compiled
          return if !rules_compiled
          rules_raw = rules_compiled.map do |rule|
            compiler_check! rule
            rule.block = eval("#{rule.block}") if sourcify?
            rule
          end
        end

        protected

        def sourcify?
          @sourcify ||= Proc.new {}.respond_to?(:to_source)
        end

        def compiler_check! rule
          if rule.block && !CanTango.adapters.registered?(:compiler)
            raise "You can NOT marshal dynamic rules (with Procs) unless you register the :compiler adapter"
          end
        end
      end
    end
  end
end
