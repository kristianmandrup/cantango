require 'set'
require 'singleton'

module CanTango
  class Configuration
    autoload_modules :Categories
    autoload_modules :Models, :Engines, :Ability
    autoload_modules :User, :Guest, :UserAccount
    autoload_modules :Roles, :RoleGroups, :Registry, :RoleRegistry, :HashRegistry, :PermitRegistry, :CandidateRegistry, :Factory
    autoload_modules :SpecialPermits, :Autoload, :Adapters, :Permits, :Debug, :Modes, :Orms, :Localhosts, :Hooks
    autoload_modules :Users, :UserAccounts

    include Singleton

    def ability
      @ability ||= conf::Ability.instance
      @ability.default_class ||= CanTango::AbilityExecutor
      @ability
    end

    def self.components
      [
        :guest, :autoload, :user, :user_account, :models, :roles, :role_groups,
        :engines, :users, :user_accounts, :categories, :adapters, :permits, :debug,
        :localhosts, :orms, :hooks
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

    def debug!
      debug.set :on
    end

    # Turn on default engines and enable compile adapter 
    # i.e compilation of rules via sourcify
    def enable_defaults!
      engines.all :off
      engine(:permit).set :on
      adapters.use :compiler
    end

    def enable_helpers *names
      names = names.to_symbols
      enable_rest_helper if names.include? :rest
    end

    def enable_rest_helper
      raise 'ApplicationController not defined' if !defined?(::ApplicationController)
      ::ApplicationController.send :include, CanTango::Rails::Helpers::RestHelper
    end

    def clear!
      CanTango::Configuration.components.each do |c|
        comp = send(c)
        comp.send(:clear!) if comp.respond_to? :clear!
      end
      engines.clear!
    end

    def include_models *names
      names = names.select_symbols
      if names.include? :default_guest_user
        require 'cantango/user/guest'
      end
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
