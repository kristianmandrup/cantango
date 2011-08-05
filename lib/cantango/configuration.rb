require 'set'

module CanTango
  class Configuration
    autoload_modules :Categories, :Engine

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

      attr_reader :guest_user_procedure, :guest_account_procedure

      def guest_user procedure
        raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @guest_user_procedure = procedure
      end

      def guest_account procedure
        raise ArgumentError, "Argument must be a Proc or lambda" if !procedure.respond_to? :call
        @guest_account_procedure = procedure
      end

      def config_path
        @config_path ||= File.join(::Rails.root.to_s, 'config') if rails?
        @config_path or raise "Define path to config files dir!\n"
      end

      def config_path= path
        raise "Must be a valid path to permission yaml file, was: #{path}" if !dir?(path)
        @config_path = path
      end

      def engines
        Engines.instance
      end

      def autoload
        Autoload.instance
      end

      def default_store_type
        @default_store_type || :redis
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
        @role_groups ||= default_roles
      end

      def roles
        @roles ||= default_roles
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
