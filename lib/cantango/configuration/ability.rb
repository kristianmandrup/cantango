module CanTango
  class Configuration
    class Ability
      include Singleton
      include ClassExt

      include CanTango::Configuration::Factory
    end
  end
end



