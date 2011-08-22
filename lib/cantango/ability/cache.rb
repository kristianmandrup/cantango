module CanTango
  class Ability
    module Cache
      autoload_modules :BaseCache, :SessionCache

      attr_reader :rules_cached

      def rules
        return cached_rules if cached_rules?
        super
      end

      def cache_rules!
        return if !caching_on?
        invalidate_cache!
        rules_cache.save cache_key, compiled_rules
        session_check!
        session[:cache_key] = cache_key
      end

      def cached_rules?
        caching_on? && cache_key_same?
      end

      def cached_rules
        @rules ||= load_rules
      end

      def cache_key
        @cache_key ||= begin
          user_key_field = CanTango.config.user.unique_key_field || :email
          raise "#{user.class} must have a method ##{user_key_field}. You can configure this with CanTango.config#user.unique_key_field" if !user.respond_to?(user_key_field)

          user_key = user.send(user_key_field)
          [user_key, subject_roles_hash].hash
        end
      end

      def subject_roles_hash
        [subject.roles_list, subject.role_groups_list].hash
      end

      def invalidate_cache!
        session_check!
        rules_cache.invalidate! session[:cache_key]
      end

      def rules_cache
        @rules_cache ||= rules_cache_instance
      end

      protected

      def compiled_rules
        compile_on? ? compile_rules!(rules) : rules
      end

      def rules_loaded
        rules_cache.load(cache_key)
      end

      def load_rules
        compile_on? ? decompile_rules!(rules_loaded) : rules_loaded
      end

      def compile_on?
        raise ":compile adapter must be used when compiler is on" if CompileCanTango.config.cache.compile? && !respond_to?(:compile_rules!)
        CanTango.config.cache.compile?
      end

      def caching_on?
        CanTango.config.cache.on?
      end

      def cache_key_same?
        session_check!
        session[:cache_key] && (cache_key == session[:cache_key])
      end

      def rules_cache_instance
        @rules_cache_instance ||= begin
          options = rules_cache_options
          options.merge!(:session => session) if session?
          rules_cache_class.new :rules_cache, options
        end
      end

      def rules_cache_options
       CanTango.config.cache.store.options || {}
      end

      def rules_cache_class
        CanTango.config.cache.store.default_class
      end

      def session?
        session
      end

      def session_check!
        raise "No session available" if !session?
      end
    end
  end
end


