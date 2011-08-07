require 'set'
require 'singleton'

module CanTango
  class Configuration
    autoload_modules :Categories
    autoload_modules :Engines, :Ability
    autoload_modules :User, :Guest, :Account
    autoload_modules :Roles, :RoleGroups, :Registry, :Factory
    autoload_modules :SpecialPermits, :Autoload

    module ClassMethods
      # allow either block or direct access
      # engine(:permission) do |permission|
      # engine(:permission).config_path
      def engine name, &block
        engine = find_engine(name)
        yield engine if block
        engine
      end

      def ability
        conf::Ability.instance
      end

      def guest
        conf::Guest.instance
      end

      def autoload
        conf::Autoload.instance
      end

      def user
        conf::User.instance
      end

      def account
        conf::Account.instance
      end

      def role_groups
        conf::RoleGroups.instance
      end

      def roles
        conf::Roles.instance
      end

      def cache
        engine(:cache)
      end

      def permissions
        engine(:permissions)
      end

      def permits
        engine(:permits)
      end

      def engines
        conf::Engines.instance
      end

      def users= *users
        @users = users.select_labels.flat_uniq
      end

      def user_accounts= *user_accounts
        @user_accounts = user_accounts.select_labels.flat_uniq
      end

      def users
        @users ||= []
      end

      def user_accounts
        @user_accounts ||= []
      end


      protected

      def find_engine name
        raise ArgumentError, "Must be label for an engine" if !name.kind_of_label?
        name = name.to_s.singularize
        engines.send(name) if engines.available? name
      end

      def conf
        CanTango::Configuration
      end
   end
    extend ClassMethods
  end
end
