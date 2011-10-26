require 'cantango/rails/railtie' if defined?(Rails)
require 'cantango/rails/engine' if defined?(Rails)
require 'cancan'
require 'cantango/cancan/rule'
require 'sugar-high/array'
require 'sugar-high/blank'
require 'hashie'
require 'sweetloader'

AutoLoader.namespaces = {:CanTango => 'cantango'}

module CanTango
  autoload_modules :Ability, :Api, :Configuration, :Cache, :Permits
  autoload_modules :PermitEngine, :PermissionEngine, :UserAcEngine, :AbilityExecutor
  autoload_modules :Rails, :Users, :Rules, :Api, :Helpers, :Filters, :Model, :Engine

  class << self
    def configure &block
      conf = CanTango::Configuration.instance
      yield conf if block
      conf
    end

    alias_method :config, :configure

    def permits_allowed candidate, actions, subjects, *extra_args
      raise "Debugging has not been turned on. Turn it on using: CanTango.debug!" if CanTango.config.debug.off?
      config.permits.allowed candidate, actions, subjects, *extra_args
    end

    def permits_denied candidate, actions, subjects, *extra_args
      raise "Debugging has not been turned on. Turn it on using: CanTango.debug!" if CanTango.config.debug.off?
      config.permits.denied candidate, actions, subjects, *extra_args
    end

    def debug_permits_registry
      puts "permits registry:" << CanTango.config.permits.show_all.inspect
    end

    def debug_ability candidate, actions, subjects, *extra_args
      puts "Ability: #{actions} on #{subjects}"
      puts "permits allowed:" << permits_allowed(candidate, actions, subjects, *extra_args).inspect
      puts "permits denied:"  << permits_denied(candidate, actions, subjects, *extra_args).inspect
    end

    def clear_permits_executed!
      config.permits.clear_executed!
    end

    def debug!
      config.debug.set :on
    end

    def debug_off!
      config.debug.set :off
    end

    def debug?
      config.debug.on?
    end
  end
end

require 'cantango/api/aliases'
require 'cantango/permits/macros'
require 'cantango/users/macros'
