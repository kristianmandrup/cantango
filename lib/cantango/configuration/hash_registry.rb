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

      def value_methods
        []
      end

      def value_types
        []
      end

      def clean!
        registered = Hashie::Mash.new
      end

      def clear!
        clean!
      end

      def default!
        @registered = default
      end

      def << hash
        raise "Must be a hash" if !hash.is_a? Hash
        registered.merge!(hash) and return if value_methods.empty? && value_types.empty?
        hash.each_pair do |key, value|
          registered[key] = value if value_api.all?{|m| value.respond_to(m)} && value.any_kind_of?(value_types)
        end
      end

      def [] label
        raise "Must be a label" if !label.kind_of_label?
        registered[label.to_s]
      end

      def []= label, value
        raise "Must be a label" if !label.kind_of_label?
        registered[label.to_s] = value
      end

      def register hash
        raise "Must be a hash" if !hash.is_a? Hash
        registered.merge! hash
      end

      def unregister name
        @registered = {} if name == :all
        @registered.delete(name)
      end

      def registered
        @registered ||= default
      end

      def registered_names
        registered.keys
      end

      def registered_values
        registered.values
      end

      def registered? label
        registered_names.map(&:to_s).include? label.to_s
      end
      alias_method :registered_name, :registered?

      def registered_value? value
        registered_values.include? value
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
