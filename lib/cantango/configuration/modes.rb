module CanTango
  class Configuration
    module Modes
      def modes
        @modes ||= [:no_cache]
      end

      def mode= mode_name
        mode_name = mode_name.to_sym
        raise ArgumentException, "Not a valid mode name" if !valid_mode_names.include? mode_name
        @modes = (mode_name == :both) ? [:cache, :no_cache] : [mode_name]
      end

      private

      def valid_mode_names
        [:cache, :no_cache]
      end
    end
  end
end
