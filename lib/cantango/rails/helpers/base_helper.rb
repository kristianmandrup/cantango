module CanTango
  module Rails
    module Helpers
      module BaseHelper
        def self.included(base)
          include_apis(base)
          # base.send :include, CanTango::Rails::Helpers::RestHelper
          base.extend ClassMethods
        end

        module ClassMethods
          def include_apis(clazz)
            return if !respond_to?(:apis) || !apis
            apis.each do |api|
              clazz.send :include, "CanTango::Api::User::#{api}".constantize
              clazz.send :include, "CanTango::Api::UserAccount::#{api}".constantize
            end
          end

          def apis
            [:Can, :Scope, :Ability, :Session]
          end
        end
        extend ClassMethods
      end
    end
  end
end
