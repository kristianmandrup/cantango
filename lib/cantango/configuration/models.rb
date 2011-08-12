module CanTango
  class Configuration
    class Models
      include Singleton
      include ClassExt

      def by_reg_exp reg_exp
        raise "Must be a Regular Expression like: /xyz/ was #{reg_exp.inspect}" if !reg_exp.kind_of? Regexp

        grep(reg_exp).map do |model_string|
          try_model(model_string)
        end
      end

      def by_category label
        categories[label].map do |model|
          model.class == String ? try_model(model) : model
        end
      end

      private

      def try_model model_string
        model = try_class(model_string.singularize) || try_class(model_string) 
        raise "No model #{model_string} defined!" if !model
        model
      end

      def models_strings
        tables.map do |table|
          table.camelize
        end
      end

      def grep reg_exp
        models_strings.grep reg_exp
      end

      def tables
        ActiveRecord::Base.connection.tables.map {|t| t.to_s }
      end

      def categories
        CanTango.config.categories
      end
    end
  end
end

