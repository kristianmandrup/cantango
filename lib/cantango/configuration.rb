require 'set'
require 'singleton'

module CanTango
  class Configuration
    autoload_modules :Categories
    autoload_modules :Engines, :Ability
    autoload_modules :User, :Guest, :UserAccount
    autoload_modules :Roles, :RoleGroups, :Registry, :Factory
    autoload_modules :SpecialPermits, :Autoload
    autoload_modules :Users, :UserAccounts

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
        @ability ||= conf::Ability.instance
        @ability.default_class ||= CanTango::Ability
        @ability
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

      def user_account
        conf::UserAccount.instance
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

      def users
        conf::Users.instance
      end

      def user_accounts
        conf::UserAccounts.instance
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
