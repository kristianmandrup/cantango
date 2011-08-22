require 'moneta'

module CanTango
  module Cache
      autoload_modules :MonetaCache
  end
end

module CanTango
  class Ability
    module Cache
      autoload_modules :MonetaCache
    end
  end
end

module CanTango
  class PermissionEngine < Engine
    autoload_modules :MonetaStore
  end
end


