module CanTango
  module Api
    module Options

      def ability_options
        opts = {}
        opts.merge!(:session => session) if respond_to? :session
        opts.merge!(:request => request) if respond_to? :request
        opts.merge!(:params => params) if respond_to? :params
        opts.merge!(:controller => controller) if respond_to? :controller
        # puts "CanTango::Ability options:" << opts.keys.inspect
        opts
      end
    end
  end
end
