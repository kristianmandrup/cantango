module CanTango
  module Users
    module User

      # include Masquerade

      attr_accessor :active_account

      def active_user
        @active_user || self
      end

      def can? *args
        CanTango::Ability.new(active_account).can?(*args)
      end

      def cannot? *args
        CanTango::Ability.new(active_account).cannot?(*args)
      end

      def active_account
        @active_account || self
      end

      def self.included(base)
        CanTango.config.users.register base.name.underscore.gsub(/_user$/, ''), base
      end
    end
  end
end
