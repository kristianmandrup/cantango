module CanTango
  class Ability
    module Cache
      autoload_modules :BaseCache, :SessionCache, :MonetaCache

      attr_reader :rules_cached

      def rules
        return cached_rules if cached_rules?
        super
      end

      def rules_cached?
        @rules_cached || false
      end

      def using_cached?
        @using_cached
      end

      def cache_rules!
        invalidate_cache!
        rules_cache.save cache_key, rules
        session[:cache_key] = cache_key
        hit_cache_for cache_key
      end

      def cache_hit? cache_key
        hit_cache[cache_key]
      end

      def cached_rules?
        cache_key_same?
      end

      def cached_rules
        @rules ||= rules_cache.load(cache_key)
      end

      def cache_key
        @cache_key ||= begin
          user_key_field = CanTango::Configuration.user_key_field || :email
          raise "#{user.class} must have a method ##{user_key_field}. You can configure this with CanTango::Configuration#user_key_field" if !user.respond_to?(user_key_field)

          user_key = user.send(user_key_field)
          [user_key, subject_roles_hash].hash
        end
      end

      def subject_roles_hash
        [subject.roles_list, subject.role_groups_list].hash
      end

      def invalidate_cache!
        rules_cache.invalidate! session[:cache_key]
      end

      def rules_cache
        @rules_cache ||= rules_cache_instance
      end

      protected

      def hit_cache
        @hit_cache ||= {}
      end

      def hit_cache_for key
        hit_cache[key] = Time.now
      end

      def cache_key_same?
        session[:cache_key] && (cache_key == session[:cache_key])
      end

      def rules_cache_instance
        @rules_cache_instance ||= rules_cache_class.new :rules_cache, rules_cache_options.merge(:session => session)
      end

      def rules_cache_options
        CanTango::Configuration.rules_cache_options || {}
      end

      def rules_cache_class
        CanTango::Configuration.rules_cache
      end
    end
  end
end

=begin
      def cache_key
        [self].hash.to_s
      end

      # rules contains the actual rules built by application of the #can and #cannot methods
      # The rules are stored in the cache using the unique key
      def cache_rules!
        key = cache_key
        rules_cache[key] ||= []
        rules_cache[key] << cached_rules
      end

      def cached_permit_rules
        key = cache_key
        rules_cache[key]
      end

      alias_method :cached_permit_rules?, :cached_permit_rules
     def caching_on?
        @caching ||= :on
      end

      def with_caching state, &block
        old_cache_state = state
        @caching = state
        yield
        @caching = old_cache_state
      end

      def rules_cache
        @rules_cache ||= {}
      end

      # dynamic rules - we don't cache them
      def permit_rules!
        with_caching :off do
          dynamic_rules # supplied by subclass
        end
      end

      def cache_permit_rules!
        with_caching :on do
          static_rules # supplied by subclass
        end
        cache_rules!
      end

      # retrieving static rules - their cached variant, or if it don't exist:
      # calling #static_rules and caching its result
      def get_permit_rules
        cached_permit_rules? ? cached_permit_rules : cache_permit_rules!
        permit_rules!
      end


=end
