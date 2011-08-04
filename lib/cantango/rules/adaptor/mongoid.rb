module CanTango
  module Rules
    module Adaptor
      module Mongoid
        #include CanTango::Rules::Adaptor::Generic
        # using #in on Hash (Mongoid query)
        def list_include
          { scope_key.in => user_scope.send(attribute) }
        end
      end
    end
  end
end
