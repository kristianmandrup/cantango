module CanTango
  class Ability
    class Cache
      class RulesCache
        attr_reader :session

        def instance
          @instance ||= clazz.new :rules_cache, options
        end

        def initialize session = nil
          @session = session
        end

        def options
          @options ||= session ? cache_options.merge(:session => session) : cache_options
        end

        def cache_options
          cache_engine.store.options || {}
        end

        def clazz
          cache_engine.store.default_class
        end

        protected

        def cache_engine
          raise "Cache engine not registered!" if !CanTango.config.engine(:cache)
          CanTango.config.engine(:cache)
        end
      end
    end
  end
end


