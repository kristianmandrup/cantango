require 'set'
require 'singleton'

module CanTango
  class Configuration
    autoload_modules :Categories
    autoload_modules :Models, :Engines, :Ability
    autoload_modules :User, :Guest, :UserAccount
    autoload_modules :Roles, :RoleGroups, :Registry, :RoleRegistry, :HashRegistry, :PermitRegistry, :Factory
    autoload_modules :SpecialPermits, :Autoload, :Adapters, :Permits
    autoload_modules :Users, :UserAccounts

    include Singleton

    def ability
      @ability ||= conf::Ability.instance
      @ability.default_class ||= CanTango::Ability
      @ability
    end

    def self.components
      [
        :guest, :autoload, :user, :user_account, :models, :roles, :role_groups,
        :engines, :users, :user_accounts, :categories, :adapters, :permits
      ]
    end

    components.each do |conf_module|
      class_eval %{
        def #{conf_module} &block
          conf = conf::#{conf_module.to_s.camelize}.instance
          yield conf if block
          conf
        end
      }
    end

    # Turn on all engines and enable compile adapter 
    # i.e compilation of rules via sourcify
    def enable_defaults!
      engines.all :on
      CanTango.adapter :compiler
    end

    def clear!
      CanTango::Configuration.components.each do |c|
        comp = send(c)
        comp.send(:clear!) if comp.respond_to? :clear!
      end
      engines.clear!
    end

    CanTango.config.engines.default_available.each do |engine|
      class_eval %{
        def #{engine}_engine
          engine(:#{engine})
        end
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

    attr_writer :localhost_list

    def localhost_list
      @localhost_list ||= ['localhost', '0.0.0.0', '127.0.0.1']
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
