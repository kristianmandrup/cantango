module Cantango
  module Generators
    module Basic
      def rules_logic
        ''
      end

      def license_logic
        ''
      end

      def base_logic
        %{
   }
      end

      def admin_logic
        %{
          can :manage, :all
    }
      end

      def guest_logic
        %{
          can :read, :all
    }
      end

      def account
        options[:account]
      end

      [:is_user, :is_account, :is_group].each do |name|
        define_method :"#{name}?" do
          false
        end
      end
    end
  end
end

