module CanTango
  module Rails
    module ViewHelpers
      include CanTango::Rails::BaseHelpers

      def self.included(base)
        include_apis(self)
      end

      def self.apis
        [] # [:Can, :Active, :Scope]
      end
    end
  end
end
