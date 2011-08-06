module CanTango
  class Ability
    module Cache
      def cache_rules!
        stamper("#cache_rules") {
        return if !caching_on?
        invalidate_cache!
        rules_compiled = compile_rules! rules
        rules_cache.save cache_key, rules_compiled
        session_check!
        session[:cache_key] = cache_key
        }
      end

      # No #stamper here.
      # Wrapping decompilator in block causes decompiler (i.e. sourcify) is not working
      def cached_rules
        time_initial = time_now
        puts "#cached_rules:"
        rules_compiled = rules_cache.load(cache_key)
        time = time_now - time_initial
        puts "  loading rules from store: (#{time}ms)"
        rules_raw = decompile_rules! rules_compiled
        time = time_now - time_initial
        puts "  decompiling rules: (#{time}ms)"

        @rules ||= rules_raw
      end

    end
  end
end
