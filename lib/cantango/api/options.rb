module CanTango
  module Api
    module Options

      def ability_options
        opts = {}
        options_list.each do |option|
          opts.merge!(option => send(option)) if respond_to? option
        end
        opts
      end

      private

      def options_list
        [:session, :request, :params, :controller, :domain]
      end
    end
  end
end
