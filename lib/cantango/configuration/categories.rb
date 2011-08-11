module CanTango
  class Configuration
    class Categories < HashRegistry
      def category label, &block
        cat = Category.new self[label]
        yield cat if block
        cat
      end

      # test if a any of the categories contain the subject
      def has_any? subject, &block
        found = registered.any? {|cat, subjects| subjects.include? subject }
        yield if found && block
        found
      end

      # find the siblings of a subject if such a category exists
      def siblings_of_subject subject, &block
        categories_of_subject(subject).values.first
      end

      # find the category of a subject if such a category exists
      def category_name_of_subject subject, &block
        categories_of_subject(subject).keys.first
      end

      # find the category of a subject if such a category exists
      def categories_of_subject subject, &block
        found_categories = registered.select do |cat, subjects|
          subjects.include? subject.to_s
        end
        found_categories.empty? ? {} : found_categories
      end

      class Category
        def initialize *subjects
          @subjects = subjects.flatten
        end

        def subjects
          @subjects ||= []
        end

        # test if a particular category has a certain subject
        def has_any? subject, &block
          found = subjects.include? subject
          yield if found && block
          found
        end
      end
    end
  end
end
