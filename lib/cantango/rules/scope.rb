module CanTango
  module Rules
    class Scope
      attr_reader :name, :permit

      def initialize name, permit, &block
        @name = name.to_sym
        @permit = permit
      end

      ::CanTango::Configuration.user_relationships.each do |relationship|
        base.class_eval %{
          def #{relationship}_of *models, &block
            options = models.extract_options!
            scope = options[:scope] || name
            relation = UserRelation.new :#{relationship}, permit, scope, models, &block
            yield relation if block
            relation
          end
        }
      end
    end
  end
end
