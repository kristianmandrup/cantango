module CanTango
  class Configuration
    class Ability
      include Singleton
      include ClassExt

      include CanTango::Configuration::Factory
      include CanTango::Configuration::Modes
    end
  end
end



