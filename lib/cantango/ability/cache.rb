module CanTango
  class Ability
    class Cache
      autoload_modules :BaseCache, :SessionCache, :Reader, :Writer, :RulesCache, :Key

      attr_reader :rules_cached, :session, :ability

      def initialize ability, options = {}
        @session = options[:session]
        @ability = ability
      end

      def cache_rules!
        writer.save key, reader.prepared_rules
      end

      def cached_rules
        @rules ||= reader.prepared_rules
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
        key.same?
      end

      def key
        @key ||= Key.new ability.user, ability.subject, session
      end

      def rules_cache
        @rules_cache ||= RulesCache.new(session).instance
      end

      def invalidate!
        raise "no session" if !session
        rules_cache.invalidate! session[:cache_key]
      end

      def compile_on?
        raise ":compile adapter must be used when compiler is on" if missing_compile_adapter?
        CanTango.config.cache.compile?
      end

      def missing_compile_adapter?
        CanTango.config.cache.compile? && !defined?(CanTango::Ability::Cache::Kompiler)
 
      end
    end
  end
end


