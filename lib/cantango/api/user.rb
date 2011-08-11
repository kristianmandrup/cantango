module CanTango
  module Api
    module User
      autoload_modules :Ability, :Can, :Scope

      module All
        def self.included base
          [:Ability, :Can, :Scope].each do |api|
            base.send :include, clazz(api)
          end
        end

        def clazz api
          ("CanTango::Api::User::" << api.to_s.camelize).constantize
        end
      end
    end
  end
end

