require 'set'

module CanTango
  class PermissionEngine < Engine
    class Store
      attr_reader :name, :options

      def initialize name, options = {}
        @name, @options = [name, options]

        options.each_pair do |name, value|
          var = :"@#{name}"
          self.instance_variable_set(var, value)
        end
      end

      def self.create name, options = {}
        self.new name, options
      end

      def load!
        raise NotImplementedError
      end

      def save! permissions
        permissions.each do |permission|
          store permission
        end
      end

    end
  end
end
