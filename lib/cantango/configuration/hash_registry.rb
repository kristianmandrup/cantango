require 'singleton'
require 'sugar-high/kind_of'

module CanTango
  class Configuration
    class HashRegistry < Registry

      def types= *types
        raise "This is a Hash registry!"
      end

      def types
        [Hash]
      end

      def clean!
        registered = Hashie::Mash.new
      end

      def default!
        @registered = default
      end

      def << hash
        raise "Must be a hash" if !hash.is_a? Hash
        registered.merge! hash
      end

      def [] label
        raise "Must be a label" if !label.kind_of_label?
        registered[label]
      end

      def []= label, value
        raise "Must be a label" if !label.kind_of_label?
        registered[label] = value
      end

      def register hash
        raise "Must be a hash" if !hash.is_a? Hash
        registered.merge! hash
      end

      def registered
        @registered ||= default
      end

      def default
        @default ||= Hashie::Mash.new
      end

      def default= hash
        @default = Hashie::Mash.new hash
      end

    end
  end
end
