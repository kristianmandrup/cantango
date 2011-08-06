# @stanislaw: needed?
require 'cantango/permit_engine/util'

module CanTango
  class Ability
    autoload_modules :ClassMethods, :Scope, :Cache

    include CanCan::Ability
    include Cache
    extend ClassMethods

    attr_reader :options, :subject, :session

    # Equivalent to a CanCan Ability#initialize call
    # which executes all the permission logic
    def initialize candidate, options = {}
      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options
      @session = options[:session] || {} # seperate session cache for each type of user?

      @rules_cached = true and return if cached_rules?

      # run permission evaluators
      with(:permissions)  {|permission| permission.evaluate! user }
      with(:permits)      {|permit| break if permit.execute == :break }

      cache_rules!
    end

    include CanTango::PermitEngine::Util

    def with engine_type, &block
      send(engine_type).each do |obj|
        yield obj
      end if send(:"#{engine_type}").on?
    end

    def subject
      return @candidate.active_user if @candidate.respond_to?(:active_user) && @candidate.masquerading?
      return @candidate.active_account if @candidate.respond_to?(:active_account)
      @candidate
    end

    def user
      return subject.user if subject.respond_to? :user
      subject
    end

    def user_account
      return subject.active_account if subject.respond_to? :active_account
      subject
    end

    # by default, only execute permits for which the user 
    # has a role or a role group
    # also execute any permit marked as special
    def permits
      permit_factory.build!
    end

    def permissions
      permission_factory.build!
    end
    # return list of symbols for roles the user has
    def roles
      raise "#{subject.inspect} should have a #roles_list method" if !subject.respond_to?(:roles_list)
      return [] if subject.roles_list.empty?
      subject.roles_list.flatten
    end

    # return list of symbols for role groups the user belongs to
    def role_groups
      raise "#{subject.inspect} should have a #role_groups_list method" if !subject.respond_to?(:role_groups_list)
      return [] if subject.role_groups_list.empty?
      subject.role_groups_list.flatten
    end

    def user_key_field
      key_field = CanTango::Configuration.user.unique_key_field
      raise "\nModel <#{user.class}> has no ##{key_field} as defined in CanTango::Configuration.user.unique_key_field!\n" if !user.respond_to?(key_field)
      key_field
    end

    def permission_factory
      @permission_factory ||= CanTango::PermissionEngine::Factory.new self
    end

    def permit_factory
      @permit_factory ||= CanTango::PermitEngine::Factory.new self
    end

    def permit_engine?
      CanTango::Configuration.permits.on?
    end

    def permission_engine?
      CanTango::Configuration.permissions.on?
    end
  end
end
