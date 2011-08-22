module CanTango
  class Ability
    module Cache
      autoload_modules :Kompiler

      include CanTango::Ability::Cache::Kompiler
    end
  end
end

