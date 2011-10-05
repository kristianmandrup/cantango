require 'sugar-high/array'

# The permit base class for both Role Permits and Role Group Permits
# Should contain all common logic
module CanTango
  module Permits
    class Permit
      attr_reader :ability

      # strategy is used to control the owns strategy (see rules.rb)
      attr_reader :strategy

      include CanTango::Api::Attributes

      # creates the permit
      def initialize ability
        @ability  = ability
      end

      def self.first_name clazz
        clazz.to_s.gsub(/^([A-Za-z]+).*/, '\1').underscore.to_sym # first part of class name
      end


      def self.account_name clazz
        return nil if clazz.name == clazz.name.demodulize
        clazz.name.gsub(/::.*/,'').gsub(/(.*)Permits/, '\1').underscore.to_sym
      end

      # executes the permit
      def execute
        puts "Execute Permit: #{self}" if CanTango.config.debug.on?        
        executor.execute!
        ability_sync!
      end

      def category label
        config.models.by_category label
      end


      def any reg_exp
        config.models.by_reg_exp reg_exp
      end

      def options
        ability.options
      end

      [:session, :controller, :request, :params].each do |obj|
        class_eval %{
          def #{obj}
            options[:#{obj}]
          end
        }
      end

      def localhost?
        config.localhost_list.include? request.host
      end

      def publichost?
        !localhost?
      end

      def subject
        ability.subject
      end

      def user
        ability.user
      end

      def user_account
        ability.user_account
      end

      def ability_rules
        ability.send(:rules)
      end

      def ability_sync!
        ability_rules << (rules - ability_rules)
        ability_rules.flatten!
      end

      # In a specific Role based Permit you can use
      #   def permit? user, options = {}
      #     return if !super(user, :in_role)
      #     ... permission logic follows
      #
      # This will call the Permit::Base#permit? instance method (the method below)
      # It will only return true if the user matches the role of the Permit class and the
      # options passed in is set to :in_role
      #
      # If these confitions are not met, it will return false and thus the outer permit 
      # will not run the permission logic to follow
      #
      # Normally super for #permit? should not be called except for this case, 
      # or if subclassing another Permit than Permit::Base
      #
      def permit?
        static_rules
        permit_rules
        dynamic_rules
      end

      def licenses *names
        names.to_strings.each do |name|
          try_license name
        end
      end

      include CanTango::Rules # also makes a Permit a subclass of CanCan::Ability

      protected

      def try_license name
        module_name = "#{name.camelize}License"
        clazz = module_name.constantize
        clazz.new(self).license_rules
      rescue NameError
        raise "License #{module_name} is not defined"
      rescue
        raise "License #{clazz} could not be enforced using #{self.inspect}"
      end

      # This method will contain the actual rules
      # can be implemented in the subclass

      def permit_rules
      end

      def static_rules
      end

      def dynamic_rules
      end

      #include CanTango::PermitEngine::Cache
      include CanTango::PermitEngine::Util
      include CanTango::PermitEngine::Compatibility

      def strategy
        @strategy ||= options[:strategy] || CanTango::Ability.strategy || :default
      end

      include CanTango::PermitEngine::RoleMatcher

      def any_role_match?
        role_match?(subject) || role_group_match?(subject)
      end

      # return the executor used to execute the permit
      def executor
        @executor ||= case self.class.name
        when /System/
          then CanTango::PermitEngine::Executor::System.new self
        else
          CanTango::PermitEngine::Executor::Base.new self
        end
      end

      def config
        CanTango.config
      end
    end
  end
end
