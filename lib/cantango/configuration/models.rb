module CanTango
  class Configuration
    class Models
      autoload_modules :Generic, :ActiveRecord, :DataMapper, :MongoMapper, :Mongoid
      autoload_modules :Actions

      include Singleton
      include ClassExt

      def actions
        @actions ||= HashRegistry.new
      end

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

      def exclude *names
        @excluded = names.flatten.select_labels
      end

      def excluded
        @excluded ||= []
      end

      def available_models
        all_models - excluded.map {|m| m.to_s.camelize}
      end

      protected

      def all_models
        CanTango.config.orms.registered.inject([]) do |result, orm|
          result << adapter_for(orm).models.map(&:name)
          result
        end.flatten.compact
      end

      private

      def adapter_for orm
        "CanTango::Configuration::Models::#{orm.to_s.camlize}".constantize.new
      end

      def try_model model_string
        model = try_class(model_string.singularize) || try_class(model_string) 
        raise "No model #{model_string} defined!" if !model
        model
      end

      def grep reg_exp
        available_models.grep reg_exp
      end

      def ar_models
        # Sugar-high #to_strings didn't work here!
        ActiveRecord::Base.descendants
      end

      def categories
        CanTango.config.categories
      end
    end
  end
end

