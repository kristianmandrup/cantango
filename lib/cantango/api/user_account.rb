module CanTango
  module Api
    module UserAccount
      autoload_modules :Ability, :Can, :Scope

      module All
        def self.included base
          [:Ability, :Can, :Scope].each do |api|
            base.send :include, clazz(api)
          end
        end

        def clazz api
          ("CanTango::Api::UserAccount::" << api.to_s.camelize).constantize
        end
      end
    end
  end
end

