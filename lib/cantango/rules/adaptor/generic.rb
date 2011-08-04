module CanTango
  module Rules
    module Adaptor
      module Generic

        def attribute_condition attribute, user_scope
          Proc.new { |model| model.send(attribute) == user_scope }
        end

        def include_condition attribute, user_scope
          Proc.new { |model| model.send(attribute).include? user_scope }
        end
      end
    end
  end
end
