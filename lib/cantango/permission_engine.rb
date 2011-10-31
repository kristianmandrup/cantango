module CanTango
  class PermissionEngine < Engine
    autoload_modules :Collector, :Compiler, :Evaluator, :Selector
    autoload_modules :Factory, :Loader, :Parser, :Permission
    autoload_modules :RulesParser, :Store, :YamlStore, :Statements, :Statement

    include CanTango::Ability::CacheHelpers

    delegate :session, :user, :subject, :cached?, :to => :ability

    def initialize ability
      super
    end

    def rules
      @rules ||= []
    end

    def clear_rules!
      @rules ||= []
    end

    def cache
      @cache ||= CanTango::Ability::Cache.new self, :cache_key => cache_key, :key_method_names => []
    end

    def execute!
      return cached_rules if !changed?

      clear_rules!
      permit_rules

      cache_rules!
      rules
    end

    def permit_rules
      return if !valid?
      debug "Permission Engine executing..."
      permissions.each do |permission|
        permission.evaluate! user
      end
    end

    def engine_name
      :permission
    end

    def valid?
      return false if !valid_mode?
      permissions.empty? ? invalid : true
    end

    def permissions
      permission_factory.build!
    end

    protected

    def cache_key
      :permissions
    end

    def invalid
      debug "No permissions found!"
      false
    end

    def permission_factory
      @permission_factory ||= CanTango::PermissionEngine::Factory.new ability
    end

    def changed?
      permission_factory.store.changed?
    end
  end
end
