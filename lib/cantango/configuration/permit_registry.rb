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

      def registered_for type, name = nil        
        name ? registered_by(type)[name.to_s] : registered_by(type)
      end

      def registered_by type
        send(type).registered
      end

      def all
        [user, account, role, role_group]
      end

      def show_all
        all.map(&:registered)
      end
    end
  end
end



