# @stanislaw: needed?
require 'cantango/permit_engine/util'

module CanTango
  class Ability
    autoload_modules :ClassMethods, :Scope, :Cache
    autoload_modules :MasqueradeHelpers, :PermitHelpers, :PermissionHelpers
    autoload_modules :UserHelpers, :RoleHelpers

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

      return if cached_rules?

      # run permission evaluators
      with(:permissions)  {|permission| permission.evaluate! user }
      with(:permits)      {|permit| break if permit.execute == :break }

      cache_rules!
    end

    include CanTango::PermitEngine::Util

    def with engine_type, &block
      send(engine_type).each do |obj|
        yield obj
      end if send(:"#{engine_type}?")
    end

    def category

    end

    def subject
      return @candidate.active_user if masquerade_user?
      return @candidate.active_account if masquerade_account?
      @candidate
    end

    include MasqueradeHelpers
    include PermissionHelpers
    include PermitHelpers
    include UserHelpers
    include RoleHelpers
  end
end
