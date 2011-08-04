module CanTango
  module PermitEngine
    autoload_modules :Builder, :Compatibility, :Executor
    autoload_modules :Factory, :Finder, :License, :Loaders, :Permit 
    autoload_modules :RoleGroupPermit, :RolePermit, :RoleMatcher, :Util 
  end
end
