module CanTango
  class Configuration
    class User
      include Singleton

      attr_reader :unique_key_field

      def unique_key_field= key
        raise ArgumentError, "Not a valid key" unless key.kind_of_label?
        @unique_key_field = key
      end
    end
  end
end


