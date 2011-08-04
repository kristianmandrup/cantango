require 'set'

module CanTango
  module PermissionEngine
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

=begin
      module ClassMethods
        attr_writer :stores

        def << store
          @stores << store
        end

        def - store
          @stores - store
        end

        def stores
          @stores ||= Set.new default_stores.map{|name| build_store name }
        end

        def load_all!
          stores.each{|store| store.load!}
        end

        # load all permissions?
        def load *store_names
          stores.select {|store| store_names.include? store.name }.each{|store| store.load!}
        end

        def default_stores
          [:role_permits, :role_group_permits, :licenses]
        end

        def build_store name, options = {}
          CanTango::Configuration.default_store.create name, options
        end
      end

      extend ClassMethods
=end
    end
  end
end
