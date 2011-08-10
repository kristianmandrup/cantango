module CanTango
  module PermissionEngine
    module Parser
      class Ownership < Rule
        def parse
          match = target[/(\w+)#(\w+)/]
          @target = match[$1]
          owner = match[$2]
          model_class = try_class
          raise "#{model_class} has no ##{owner}!" if !model_class.new.respond_to?(owner.to_sym)
          result = [ "#{owner.singularize}_of(#{target}) do |#{owner}|",
                     "  #{owner}.#{method} :#{action}",
                     "end" ]
          result.join("\n")
        end
      end
    end
  end
end



