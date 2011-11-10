module CanTango
  module Permits
    autoload_modules :Executor
    autoload_modules :License, :Permit

    autoload_modules :RoleGroupPermit,  :RoleGroupPermitBuilder
    autoload_modules :RolePermit,       :RolePermitBuilder
    autoload_modules :UserPermit,       :UserPermitBuilder
    autoload_modules :AccountPermit,    :AccountPermitBuilder
  end
end


