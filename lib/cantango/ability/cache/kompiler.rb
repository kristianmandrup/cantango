require 'sourcify'

module CanTango
  class Ability
    class Cache
      class Kompiler

        def compile! rules_raw
          rules_compiled = rules_raw.map do |rule|
            rule.block = rule.block.to_source if rule.block.class == Proc
            rule
          end
        end

        def decompile! rules_compiled
          rules_raw = rules_compiled.map do |rule|
            rule.block = eval("#{rule.block}")
            rule
          end
        end

      end
    end
  end
end
