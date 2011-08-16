# @stanislaw: needed?
require 'cantango/permit_engine/util'

module CanTango
  class Ability
    autoload_modules :ClassMethods, :Scope, :Cache
    autoload_modules :MasqueradeHelpers, :PermitHelpers, :PermissionHelpers
    autoload_modules :UserHelpers, :RoleHelpers

    include CanCan::Ability
    include Cache
    extend  ClassMethods

    attr_reader :options, :subject, :session

    # Equivalent to a CanCan Ability#initialize call
    # which executes all the permission logic
    def initialize candidate, options = {}
      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options
      @session = options[:session] || {} # seperate session cache for each type of user?

      return if cached_rules?

      execute_engines!

      cache_rules!
    end

    include CanTango::PermitEngine::Util

    def execute_engines!
      engines.execution_order.each {|name| engines.registered[name].new(ability).execute!  }
    end

    def engines
      CanTango.config.engines
    end

    def subject
      return @candidate.active_user if masquerade_user?
      return @candidate.active_account if masquerade_account?
      @candidate
    end

    def config
      CanTango.config
    end

    include MasqueradeHelpers
    include PermissionHelpers
    include PermitHelpers
    include UserHelpers
    include RoleHelpers
  end
end
