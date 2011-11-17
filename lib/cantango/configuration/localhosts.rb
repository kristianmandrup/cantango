module CanTango
  class Configuration
    class Localhosts < Registry
      include Singleton
      
      def default
        @default ||= ['localhost', '0.0.0.0', '127.0.0.1']
      end
    end
  end
end

