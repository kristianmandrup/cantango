module CanTango
  class Ability
    module Helper
      module Cache
        include CanTango::Helpers::RoleMethods

        delegate :cache_rules!, :cached_rules, :cached_rules?, :to => :cache

        def cache options = {}
          @cache ||= CanTango::Ability::Cache.new self, options
        end
      end
    end
  end
end
