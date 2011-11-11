module CanTango
  class PermissionEngine < Engine
    module Parser
      class Category < Rule
       # remove the '@' prefix to get the category name
       # look up the category and get models referenced by said category
        attr_reader :categories

        def initialize method, action, target
          super
          load_categories
        end

        def parse
          cat_name = target.gsub(/^\^/, '').to_sym
          targets = category_models_for(cat_name).map{|model| parse_class(model)}
          targets.inject([]) do |statements, target|
            statements << "#{method}(:#{action}, #{target})"
          end
        end

        def category_models_for name
          categories.registered[name.to_s]
        end

        def load_categories
          @categories = CanTango::PermissionEngine::Loader::Categories.new.categories
        end
      end
    end
  end
end


