module CanTango
  module Rails
    module Helpers
      module ViewHelpers
        include CanTango::Rails::Helpers::BaseHelper

        def self.included(base)
          include_apis(self)
        end

        def self.apis
          [] # [:Can, :Active, :Scope]
        end
      end
    end
  end
end
