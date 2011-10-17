module CanTango
  module Users
    module UserAccount
      include CanTango::Users::Masquerade

      def active_user
        @active_user || user
      end

      def can? *args
        CanTango::Ability.new(self).can?(*args)
      end

      def cannot? *args
        CanTango::Ability.new(self).cannot?(*args)
      end

      def self.included(base)
        CanTango.config.user_accounts.register base.name.underscore.gsub(/_account$/, ''), base
      end
    end
  end
end
