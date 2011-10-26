require 'cantango/permit_engine/util'

module CanTango
  class Ability
    autoload_modules :Scope, :Cache
    autoload_modules :MasqueradeHelpers, :PermitHelpers, :PermissionHelpers
    autoload_modules :UserHelpers, :RoleHelpers, :CacheHelpers, :EngineHelpers

    include CanCan::Ability

    attr_reader :options, :candidate

    # Equivalent to a CanCan Ability#initialize call
    # which executes all the permission logic
    def initialize candidate, options = {}
      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options

      clear_rules!
      permit_rules

      execute_engines! if engines_on?
    end

    include CanTango::PermitEngine::Util

    def cached?
      false
    end

    def permit_rules
    end

    def clear_rules!
      @rules ||= default_rules
    end

    def session
      @session = options[:session] || {} # seperate session cache for each type of user?
    end

    def subject
      return candidate.active_user if masquerade_user?
      return candidate.active_account if masquerade_account?
      candidate
    end

    def config
      CanTango.config
    end

    include EngineHelpers
    include CacheHelpers
    include MasqueradeHelpers
    include PermissionHelpers
    include PermitHelpers
    include UserHelpers
    include RoleHelpers

    protected

    def default_rules
      []
    end
  end
end
