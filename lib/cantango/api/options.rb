module CanTango
  module Api
    module Options

      def ability_options
        opts = {}
        options_list.each do |option|
          opts.merge!(option => send(option)) if respond_to? option, true
        end
        opts
      end

      def self.options_list
        [:session, :request, :params, :controller, :domain, :cookies]
      end

      private

      def options_list
        self.class.options_list
      end
    end
  end
end
