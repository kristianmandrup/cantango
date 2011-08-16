module CanTango
  class PermissionEngine < Engine
    module Loader
      autoload_modules :Base, :Categories, :Permissions
    end
  end
end
