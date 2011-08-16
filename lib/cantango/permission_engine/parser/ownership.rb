module CanTango
  class PermissionEngine < Engine
    module Parser
      class Ownership < Rule
        attr_reader :model_class, :owner

        def parse
          match = target[/(\w+)#(\w+)/]

          @target = match[$1]
          @owner = match[$2]
          @model_class = try_class
          build_ownership_dsl
        end

        protected

        def build_ownership_dsl
          raise "#{model_class} has no ##{owner}!" if !model_class.new.respond_to?(owner.to_sym)
          ownership_dsl_lines
        end

        def ownership_dsl_lines
          "#{owner.singularize}_of(#{target}).#{method} :#{action}"
        end
      end
    end
  end
end



