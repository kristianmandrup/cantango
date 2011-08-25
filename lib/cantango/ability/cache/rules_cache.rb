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
          CanTango.config.cache.store.options || {}
        end

        def clazz
          CanTango.config.cache.store.default_class
        end
      end
    end
  end
end


