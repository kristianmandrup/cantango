module CanTango
  module PermitEngine
    autoload_modules :Builder, :Compatibility, :Executor
    autoload_modules :Factory, :Finder, :License, :Loaders, :Permit
    autoload_modules :RoleGroupPermit, :RolePermit, :UserPermit, :AccountPermit
    autoload_modules :RoleMatcher, :Util
  end
end
