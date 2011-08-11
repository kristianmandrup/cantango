require 'set'
require 'singleton'

module CanTango
  class Configuration
    autoload_modules :Categories
    autoload_modules :Engines, :Ability
    autoload_modules :User, :Guest, :UserAccount
    autoload_modules :Roles, :RoleGroups, :Registry, :RoleRegistry, :Factory
    autoload_modules :SpecialPermits, :Autoload
    autoload_modules :Users, :UserAccounts

    include Singleton

    def ability
      @ability ||= conf::Ability.instance
      @ability.default_class ||= CanTango::Ability
      @ability
    end

    [:guest, :autoload, :user, :user_account, :roles, :role_groups, :engines, :users, :user_accounts].each do |conf_module|
      class_eval %{
        def #{conf_module} &block
          conf = conf::#{conf_module.to_s.camelize}.instance
          yield conf if block
          conf
        end
      }
    end

    CanTango::Configuration::Engines.available.each do |engine|
      class_eval %{
        def #{engine}
          engine(:#{engine})
        end

        alias_method :#{engine.to_s.pluralize}, :#{engine}
      }
    end

    # allow either block or direct access
    # engine(:permission) do |permission|
    # engine(:permission).config_path
    def engine name, &block
      engine = find_engine(name)
      yield engine if block
      engine
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
end
