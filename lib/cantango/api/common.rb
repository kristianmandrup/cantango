module CanTango
  module Api
    module Common
      include CanTango::Api::Attributes

      def create_ability candidate, opts = {}
        CanTango.config.ability.factory_build candidate, opts
      end

      def category label
        config.models.by_category label
      end
    end
  end
end

