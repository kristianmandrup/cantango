module CanTango
  class Ability
    class Cache
      autoload_modules :BaseCache, :SessionCache, :Reader, :Writer, :RulesCache, :Key

      include CanTango::Helpers::RoleMethods

      attr_reader :rules_cached, :ability
      attr_writer :key_method_names, :cache_key

      delegate :session, :cached?, :to => :ability

      def initialize ability, options = {}
        @ability = ability
        @cache_key = options[:cache_key]
        @key_method_names = options[:key_method_names]
      end

      def key_method_names
        @key_method_names ||= [roles_list_meth, role_groups_list_meth]
      end

      def cache_key
        @cache_key ||= :cache
      end

      def cache_rules!
        writer.save(key, reader.prepared_rules) if cached?
      end

      def cached_rules
        @rules ||= reader.prepared_rules if cached?
      end

      def compiler
        @compiler ||= Kompiler.new
      end

      def reader
        @reader ||= Reader.new(self)
      end

      def writer
        @writer ||= Writer.new(self)
      end

      def cached_rules?
        key.same?(session) && cached?
      end

      def key
        @key ||= Key.new ability.user, ability.subject, key_method_names
      end

      def rules_cache
        @rules_cache ||= RulesCache.new(session).instance
      end

      def invalidate!
        raise "no session" if !session
        rules_cache.invalidate! session[cache_key]
      end

      def compile_on?
        return false if !compile_adapter?
        CanTango.config.cache_engine.compile?
      end

      def compile_adapter?
        CanTango.config.adapters.registered?(:compiler)
      end
    end
  end
end


