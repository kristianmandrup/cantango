module CanTango
  class Ability
    module Helper
      module Engine
        def execute_engines!
          each_engine do |engine|
            engine_rules = engine.new(self).execute! if engine
            @rules << engine_rules if !engine_rules.blank?
          end
        end

        def each_engine &block
          engines.execution_order.each do |name|
            yield engines.registered[name] if engines.active? name
          end
        end

        def opts_engines_off?
          options[:engines] == :off
        end

         def engines_on?
          CanTango.config.engines.any?(:on) && !opts_engines_off?
        end

        def engines
          CanTango.config.engines
        end
      end
    end
  end
end