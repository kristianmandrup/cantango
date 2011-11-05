module CanTango
  module Cache
    class HashCache
      include Singleton

      attr_reader :options

      def configure_with options = {}
        @options ||= options
      end

      def load! key
        raise "no key" if key.nil?
        cache[key]
      end

      def save! key, rules
        raise "no key" if key.nil?
        cache[key] = rules
      end

      def delete key
        raise "no key" if key.nil?
        cache[key].delete if cache[key]
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

