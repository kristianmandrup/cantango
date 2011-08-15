require 'cantango/rails/railtie' if defined?(Rails)
require 'cantango/rails/engine' if defined?(Rails)
require 'cancan'
require 'cantango/cancan/rule'
require 'sugar-high/class_ext'
require 'sugar-high/array'
require 'sugar-high/blank'
require 'hashie'
require 'cutter'
require 'moneta'

# AutoLoader.root = ''
AutoLoader.namespaces = {:CanTango => 'cantango'}

module CanTango
  autoload_modules :Ability, :Api, :Configuration, :Cache
  autoload_modules :PermitEngine, :Rails, :Users
  autoload_modules :PermissionEngine, :Rules, :Api, :Helpers, :Filters

  class << self
    def configure &block
      conf = CanTango::Configuration.instance
      yield conf if block
      conf
    end

    alias_method :config, :configure
  end
end

require 'cantango/api/aliases'
require 'cantango/users/macros'
