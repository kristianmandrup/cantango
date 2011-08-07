module CanTango
  module Api
    module Common
      def create_ability candidate, opts = {}
        CanTango.config.ability.factory_build candidate, opts
      end
    end
  end
end

