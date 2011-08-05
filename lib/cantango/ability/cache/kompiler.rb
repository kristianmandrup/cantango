require 'sourcify'
module CanTango
  class Ability
    module Cache
      module Kompiler

        def compile_rules! rules_raw
          rules_compiled = rules_raw.map do |rule|
            rule.block = rule.block.to_source if rule.block.class == Proc
            puts rule.block
            rule
          end
        end

        def decompile_rules! rules_compiled
          rules_raw = rules_compiled.map do |rule|
            rule.block = eval("#{rule.block}")
            rule
          end
        end

      end
    end
  end
end
