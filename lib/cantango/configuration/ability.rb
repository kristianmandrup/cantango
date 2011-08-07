module CanTango
  class Configuration
    module Ability
      include Singleton
      include CanTango::Configuration::Factory
    end
  end
end



