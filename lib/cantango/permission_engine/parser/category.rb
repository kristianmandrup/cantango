module CanTango
  module PermissionEngine
    module Parser
      class Category < Rule
       # remove the '@' prefix to get the category name
       # look up the category and get models referenced by said category
        attr_reader :categories

        def initialize target
          super
          load_categories
        end

        def parse
          category = target.gsub(/^\^/, '').to_sym 
          categories.category_of_subject(category).map{|model| parse_class(model)} 
        end

        def load_categories
          @categories = CanTango::PermissionEngine::Loader::Categories.new
        end

      end
    end
  end
end


