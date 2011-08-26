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
  autoload_modules :PermitEngine, :Rails, :Users
  autoload_modules :PermissionEngine, :Rules, :Api, :Helpers, :Filters, :Engine

  class << self
    def configure &block
      conf = CanTango::Configuration.instance
      yield conf if block
      conf
    end

    alias_method :config, :configure

    def adapter name
      raise "Unknown adapter #{name}" if !available_adapters.include? name.to_sym
      require "cantango/adapter/#{name}"
    end

    def adapters *names
      names.each {|name| adapter name }
    end

    def available_adapters
      [:moneta, :compiler]
    end
  end
end

require 'cantango/api/aliases'
require 'cantango/permits/macros'
require 'cantango/users/macros'
