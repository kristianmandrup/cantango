module CanTango
  module Rules
    module Adaptor
      module Relational
        def attribute_condition attribute, user_scope
          { attribute.to_sym => user_scope.send(attribute) }
        end
        alias_method :include_condition, :attribute_condition
      end
    end
  end
end

