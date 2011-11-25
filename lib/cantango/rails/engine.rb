module CanTango
  # Include helpers in the given scope to AC and AV.
  # "Borrowed" from devise
  def self.include_helpers(scope)
    # Seems like the order of initializers is important! ActiveRecord should go first!
    ActiveSupport.on_load(:active_record) do
      RailsAutoLoader.load_models! if CanTango.config.autoload.models?
    end

    ActiveSupport.on_load(:action_controller) do
      include scope::Rails::Helpers::ControllerHelper
    end

    ActiveSupport.on_load(:action_view) do
      include scope::Rails::Helpers::ViewHelper
    end
  end

  # http://edgeguides.rubyonrails.org/configuring.html
  # - before_configuration: This is run as soon as the application constant inherits from Rails::Application. The config calls are evaluated before this happens.
  # - before_initialize: This is run directly before the initialization process of the application occurs with the :bootstrap_hook initializer near the beginning of the Rails initialization process.
  # - to_prepare: Run after the initializers are ran for all Railties (including the application itself), but before eager loading and the middleware stack is built. More importantly, will run upon every request in development, but only once (during boot-up) in production and test.
  # - before_eager_load: This is run directly before eager loading occurs, which is the default behaviour for the production environment and not for the development environment.
  # - after_initialize: Run directly after the initialization of the application, but before the application initializers are run.
  class RailsEngine < ::Rails::Engine
    initializer "cantango.helpers" do
      CanTango.include_helpers(CanTango)

      # load all models
      # this is needed in order to register all users and accounts with CanTango using the user/account macros!
    end

    config.to_prepare do
      CanTango.to_prepare

      # load all permits (development mode: EVERY request!)
      RailsAutoLoader.load_permits! if CanTango.config.autoload.permits?
    end

    config.after_initialize do
      CanTango.after_initialize
    end
  end

  module RailsAutoLoader
    def self.load_models!
      load_files! :models
    end

    def self.load_permits!
      load_files! :permits
    end

    private

    def self.load_files! path
      Dir[::Rails.root + "app/#{path}/**/*.rb"].each do |path|
        require_dependency path
      end
    end
  end
end

