module CanTango
  class Configuration
    class Models
      include Singleton
      include ClassExt

      def by_reg_exp reg_exp
        raise "Must be a Regular Expression like: /xyz/ was #{reg_exp.inspect}" if !reg_exp.kind_of? Regexp

        grep(reg_exp).map do |model_string|
          try_class(model_string.singularize) || try_class(model_string)
        end
      end

      private

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

    end
  end
end

