module CanTango
  module Rules
    module Adaptor
      module Mongo
        #include CanTango::Rules::Adaptor::Generic
        # using #in on Hash (Mongoid query)
        def include_condition attribute, user_scope
          { attribute.to_sym.in => user_scope.send(attribute) }
        end

        def attribute_condition attribute, user_scope
          { attribute.to_sym => user_scope.send(attribute) }
        end
      end
    end
  end
end


