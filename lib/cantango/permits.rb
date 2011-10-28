module CanTango
  module Permits
    autoload_modules :Executor
    autoload_modules :License, :Permit
    autoload_modules :RoleGroupPermit, :RolePermit
    autoload_modules :UserPermit, :AccountPermit
  end
end


