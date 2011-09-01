module CanTango
  class Configuration
    class PermitRegistry
      [:user, :account, :role, :role_group].each do |permit|
        class_eval %{
          def #{permit}
            @#{permit} ||= HashRegistry.new
          end
        }
      end

    end
  end
end



