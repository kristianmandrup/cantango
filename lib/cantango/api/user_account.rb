module CanTango
  module Api
    module UserAccount
      autoload_modules :Ability, :Active, :Can, :Scope
 
      module All
        def self.included base
          [:Ability, :Active, :Can, :Scope].each do |api|
            base.send :include, api
          end
        end
      end
    end
  end
end

