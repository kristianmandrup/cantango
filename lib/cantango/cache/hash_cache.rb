module CanTango
  module Cache
    class HashCache
      include Singleton

      attr_reader :options

      def configure_with options = {}
        @options ||= options
      end

      def load! key
        cache[key]
      end

      def save! key, rules
        cache[key] = rules
      end

      def delete key
        cache[key].delete
      end

      def cache
        @cache ||= {}
      end

      def type
        :memory
      end
    end
  end
end

