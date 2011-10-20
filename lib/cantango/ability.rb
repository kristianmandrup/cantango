require 'cantango/permit_engine/util'

module CanTango
  class Ability
    autoload_modules :Scope, :Cache
    autoload_modules :MasqueradeHelpers, :PermitHelpers, :PermissionHelpers
    autoload_modules :UserHelpers, :RoleHelpers, :CacheHelpers, :EngineHelpers

    include CanCan::Ability

    attr_reader :options, :subject, :session, :candidate, :caching_on, :engines_on, :mode

    # Equivalent to a CanCan Ability#initialize call
    # which executes all the permission logic
    def initialize candidate, options = {}
      raise "Candidate must be something!" if !candidate
      @candidate, @options = candidate, options
      @session = options[:session] || {} # seperate session cache for each type of user?

      @caching_on = options[:caching] != :off
      @engines_on = options[:engines] != :off

      return if cached_rules?

      clear_rules!
      permit_rules

      execute_engines! if engines_on?
      cache_rules! if any_caching_on?
    end

    include CanTango::PermitEngine::Util

    def mode
      :cached
    end

    def mode? mode
      self.mode == mode
    end

    def permit_rules
    end

    def clear_rules!
      @rules ||= default_rules
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
