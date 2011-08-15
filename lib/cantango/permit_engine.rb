module CanTango
  class PermitEngine < Engine
    autoload_modules :Builder, :Compatibility, :Executor
    autoload_modules :Factory, :Finder, :License, :Loaders, :Permit
    autoload_modules :RoleGroupPermit, :RolePermit, :UserPermit, :AccountPermit
    autoload_modules :RoleMatcher, :Util

    def initialize ability
      super
    end

    def execute!
      permits.each do |permit| 
        break if permit.execute == :break
      end
    end

    # by default, only execute permits for which the user
    # has a role or a role group
    # also execute any permit marked as special
    def permits
      permit_factory.build!
    end

    def permit_class_names
      @permit_class_names ||= permits.map{|p| p.class.to_s}
    end

    protected

    def permit_factory
      @permit_factory ||= CanTango::PermitEngine::Factory.new ability
    end
  end
end
