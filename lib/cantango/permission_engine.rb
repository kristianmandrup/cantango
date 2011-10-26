module CanTango
  class PermissionEngine < Engine
    autoload_modules :Collector, :Compiler, :Evaluator, :Selector
    autoload_modules :Factory, :Loader, :Parser, :Permission
    autoload_modules :RulesParser, :Store, :YamlStore, :Statements, :Statement

    def initialize ability
      super
    end

    def execute!
      return if !valid?
      debug "Permission Engine executing..."
      permissions.each do |permission|
        permission.evaluate! user
      end
    end

    def valid?
      permissions.empty? ? invalid : true
    end

    def permissions
      permission_factory.build!
    end

    protected

    def invalid
      debug "No permissions found!"
      false
    end

    def permission_factory
      @permission_factory ||= CanTango::PermissionEngine::Factory.new ability
    end
  end
end
