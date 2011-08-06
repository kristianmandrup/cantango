module CanTango
  module Api
    module UserAccount
      autoload_modules :Ability, :Can, :Scope

      module All
        def self.included base
          [:Ability, :Can, :Scope].each do |api|
            base.send :include, api
          end
        end
      end
    end
  end
end

