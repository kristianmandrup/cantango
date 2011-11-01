module CanTango
  class PermissionEngine < Engine
    autoload_modules :Collector, :Compiler, :Evaluator, :Selector
    autoload_modules :Factory, :Loader, :Parser, :Permission
    autoload_modules :RulesParser, :Store, :YamlStore, :Statements, :Statement

    include CanTango::Ability::Executor
    include CanTango::Ability::RoleHelpers
    include CanTango::Ability::UserHelpers

    def initialize ability
      super
    end

    def permit_rules
      permissions.each do |permission|
        permission.evaluate! user
      end
    end

    def engine_name
      :permission
    end

    def valid?
      puts "valid_mode? #{valid_mode?} #{modes} #{cached?}"
      return false if !valid_mode?
      permissions.empty? ? invalid : true
    end

    def permissions
      permission_factory.build!
    end

    protected

    alias_method :cache_key, :engine_name

    def start_execute
      debug "Permission Engine executing..."
    end

    def end_execute
      debug "Done Permission Engine"
    end

    def invalid
      debug "No permissions found!"
      false
    end

    def permission_factory
      @permission_factory ||= CanTango::PermissionEngine::Factory.new self
    end

    def changed?
      permission_factory.store.changed?
    end
  end
end
