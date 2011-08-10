module CanTango
  class Configuration
    class RoleRegistry < Registry
      attr_reader :has_method, :list_method

      [:has_method, :list_method].each do |meth|
        class_eval %{
          def #{meth}
            @#{meth} ||= default_#{meth}
          end

          def #{meth}= name
            raise "Must be a label" if !name.kind_of_label?
            @#{meth} = name
          end
        }
      end
    end
  end
end

