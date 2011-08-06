require 'yaml'

module CanTango
  module PermissionEngine
    class YamlStore < Store
      attr_reader :path

      # for a YamlStore, the name is the name of the yml file
      # options: extension, path

      def initialize name, options = {}
        super
      end

      def self.create name, options = {}
        super
      end

      def load!
        loader.load!
      end

      def load_from_hash hash
        loader.load_from_hash hash
      end

      # @stanislaw: don't like this, because what if loader#load! will be called
      # twice during object's (YamlStore.new) life time!
      def permissions
        @permissions ||= loader.permissions
      end

      CanTango::Configuration.engine(:permission).types.each do |type|
        define_method(:"#{type}_permissions") do
          loader.send(:"#{type}_permissions")
        end

        define_method(:"#{type}_permissions_rules") do
          send(:"#{type}_permissions").inject({}) do |result,(pk,pv)| 
            result.merge(pv.to_hash)
          end
        end

        define_method(:"#{type}_permissions_to_hash") do
          { type.to_s => send(:"#{type}_permissions_rules") }
        end

        define_method(:"#{type}_compiled_permissions") do
          loader.send(:"#{type}_compiled_permissions")
        end

        # @stanislaw: this needs revision!
        
        define_method(:"#{type}_rules") do
          #cache(":#{type}") || 
          send(:"#{type}_compiled_permissions")
        end
      end

      def save! perms = nil
        save_permissions(perms) if perms
       
        File.open(file_path+".yml", 'w') do |f|
          f.write to_yaml
        end
      end

      def save_permissions(perms)
        load_from_hash perms
      end

      protected

      def permission_types
        CanTango::Configuration.permission_types
      end
      
      def to_yaml
        permission_types.inject({}) do |collection, type|
          collection.merge(send(:"#{type}_permissions_to_hash"))
        end.to_yaml.gsub(/"(@\w+)"/,'\1') # hash.to_yaml leaves quotes on strings prefixed with @
      end

      def loader
        @loader ||= CanTango::PermissionEngine::Loader::Permissions.new file_path
      end

      def file_path
        File.join(path, file_name)
      end

      private

      def file_name
        [name, extension].join('.')
      end

      def extension
        @extension || default_ext
      end

      def default_ext
        'yml'
      end

    end
  end
end
