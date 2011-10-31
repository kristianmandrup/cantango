module CanTango
  class Configuration
    class Engines
      class Cache < Engine

        def compile state
          raise "Must be set to :on or :off" if ![:on, :off].include? state
          @compile = state
        end

        def compile?
          @compile ||= :on
          @compile == :on
        end

        def store &block
          @store ||= ns::Store.new
          # CanTango::Ability::Cache::MonetaCache
          @store.default_class ||= CanTango::Ability::Cache::SessionCache
          yield @store if block
          @store
        end
      end
    end
  end
end


