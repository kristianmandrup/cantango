module CanTango
  class Configuration
    class PermitRegistry
      attr_reader :accounts

      [:user_type, :account_type, :role :role_group].each do |permit|
        class_eval %{
          def #{permit}
            @#{permit} ||= HashRegistry.new
          end
        }
      end
    end
  end
end



