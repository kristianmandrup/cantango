module CanTango
  class PermissionEngine < Engine
    module Parser
      class Regex < Rule
        attr_reader :regex

        def parse
          target.gsub!(/\/(.*)\//, '\1')
          @regex = /#{target}/
          build_statement
        end

        private

        def targets
          config_models.by_reg_exp(regex)
        end

        def build_statement
          targets.map do |target|
            "#{method} :#{action}, #{target.name}"
          end.join("\n")
        end

        def config_models
          CanTango.config.models
        end

      end
    end
  end
end



