module CanTango
  class PermitEngine < Engine
    class PermitBuilder
      class CreatePermitError < StandardError; end

      include CanTango::Helpers::Debug

      attr_accessor :ability, :finder

      # creates the factory for the ability
      # note that the ability contains the roles and role groups of the user (or account)
      # @param [Permits::Ability] the ability
      def initialize ability
        @ability = ability
      end

      def self.permit_type
        self.name.demodulize.gsub(/(.*)(Builder)/, '\1').underscore.to_sym
      end

      def permit_type
        self.class.permit_type
      end

      # should be implemented by builder subclass!
      def build
        raise NotImplementedError
      end

      protected

      # Tries to create a new permit
      # If no permit Class can be found, it should return nil
      # @param [Symbol] the name
      # @return the permit Class or nil if not found
      def create_permit name
        begin
          permit_class(name).new ability
        rescue RuntimeError => e
          # puts "Error instantiating Permit instance for #{name}, cause: #{e}" if CanTango.debug?
          nil
        end
      end

      def permit_class name
        finder(name).get_permit
      end

      def finder name
        CanTango::PermitEngine::PermitFinder.new name, permit_type, account_name
      end

      # TODO: FIX!
      def account_name
        user_account.class.name.underscore.to_sym if user_account
      end

      # delegate to ability
      [:options, :subject, :user, :user_account].each do |name|
        define_method name do
          ability.send(name)
        end
      end
=begin
      def available_role_groups
        CanTango.config.role_groups
      end

      def available_roles
        CanTango.config.roles
      end
=end
    end
  end
end
