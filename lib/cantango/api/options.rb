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

      def options_list
        CanTango::Api::Options.options_list
      end
    end
  end
end
