module CanTango
  class Ability
    module Cache
      autoload_modules :BaseCache, :SessionCache, :Reader, :Writer, :RulesCache

      attr_reader :rules_cached

      include Reader
      include Writer

      def rules
        return cached_rules if cached_rules?
        super
      end

      protected

      def compile_on?
        raise ":compile adapter must be used when compiler is on" if CompileCanTango.config.cache.compile? && !respond_to?(:compile_rules!)
        CanTango.config.cache.compile?
      end

      def caching_on?
        CanTango.config.cache.on?
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

      def cache_key_same?
        session_check!
        session[:cache_key] && (cache_key == session[:cache_key])
      end

      def rules_cache
        @rules_cache ||= RulesCache.new(session).instance
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


