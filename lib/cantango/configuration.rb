require 'set'

module CanTango
  class Configuration
    autoload_modules :Categories, :Engines, :Roles, :RoleGroups

    module ClassMethods
      attr_writer :role_groups, :roles
      attr_writer :default_roles, :default_role_groups
      attr_writer :special_permits, :user_relationships
      attr_writer :localhost_manager
      attr_writer :store, :rules_cache

      attr_writer :default_store, :default_rules_cache
      attr_writer :default_store_type, :default_cache_type

      attr_accessor :user_key_field
      attr_accessor :user_accounts, :users

      def guest
        Guest.instance
      end

      def engines
        Engines.instance
      end

      def autoload
        Autoload.instance
      end

      def user
        User.instance
      end

      def default_cache_type
        @default_cache_type || :memory
      end

      def permission_types
        [:roles, :role_groups, :licenses, :users]
      end

      def store
        @store ||= default_store
      end

      # set type of storage?
      def default_store
        CanTango::PermissionEngine::YamlStore
      end

      def rules_cache
        @rules_cache ||= default_rules_cache
      end

      def rules_cache_options= options = {}
        raise ArgumentError, "Must be a Hash, was #{options}" if !options.kind_of? Hash
        @rules_cache_options = {:type => default_cache_type}.merge options
      end

      def rules_cache_options
        @rules_cache_options ||= {}
      end

      def default_rules_cache
        CanTango::Ability::Cache::MonetaCache
      end

      def user_key_field
        @user_key_field || :email
      end

      def role_groups
        RoleGroups.instance
      end

      def roles
        Roles.instance
      end

      def user_relationships
        [:owner, :author, :writer, :user]
      end

      def special_permits
        @special_permits ||= Set.new 
        @special_permits = default_special_permits if @special_permits.empty?
        @special_permits
      end

      def default_roles
        @default_roles ||= [:admin, :guest]
      end

      def default_role_groups
        @default_role_groups ||= []
      end

      def special_permits= permits
        @special_permits = permits & default_special_permits
      end

      def default_special_permits
        [:system, :any]
      end

      private

      def rails?
        defined?(::Rails) && ::Rails.respond_to?(:root)
      end

      def dir? dir
        return false if !dir
        File.directory?(dir)
      end
    end
    extend ClassMethods
  end
end
