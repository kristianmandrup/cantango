module CanTango
  class Configuration
    class User
      include Singleton

      include ClassExt

      def clear!
        @clazz = nil
        @unique_key_field = nil
        @relations = nil
      end

      def base_class
        @clazz ||= (::User if defined? ::User)
      end

      def base_class= clazz
        raise ArgumentError, "Must be a class, was: #{clazz}" unless is_class? clazz
        @clazz = clazz
      end

      def unique_key_field
        @unique_key_field || :email
      end

      def unique_key_field= key
        raise ArgumentError, "Not a valid key" unless key.kind_of_label?
        @unique_key_field = key.to_sym
      end

      def relations= *relations
        @relations = relations.select_labels
      end

      def relations
        @relations ||= default_relations
      end

      def default_relations
        [:owner, :author, :writer, :user]
      end
    end
  end
end


