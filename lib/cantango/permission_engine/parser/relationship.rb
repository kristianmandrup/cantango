module CanTango
  class PermissionEngine < Engine
    module Parser
      class Relationship < Rule
        def parse
          match = target[/(\w+)#(\w+)=(.+)/]
          @target = match[$1]
          lstat = match[$2]
          rstat = match[$3]

          model_class = try_class
          raise "#{model_class} has no ##{lstat}!" if !model_class.new.respond_to?(lstat.to_sym)
          conditions = ":#{lstat} => #{rstat}"

          target_and_conditions = [ target, conditions ].compact.join(', ')
          "#{method}(:#{action}, #{target_and_conditions})"
        end
      end
    end
  end
end


