module CanTango
  # Include helpers in the given scope to AC and AV.
  # "Borrowed" from devise
  def self.include_helpers(scope)
    ActiveSupport.on_load(:action_controller) do

      include scope::Rails::ControllerHelpers
    end

    ActiveSupport.on_load(:action_view) do

      include scope::Rails::ViewHelpers
    end
  end

  class Engine < ::Rails::Engine
    initializer "cantango.helpers" do
      CanTango.include_helpers(CanTango)

      # load all models
      # this is needed in order to register all users and accounts with CanTango using the user/account macros!
      RailsAutoLoader.load_models! if CanTango::Configuration.autoload_models?

      # load all permits
      RailsAutoLoader.load_permits! if CanTango::Configuration.autoload_permits?
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
        require path
      end
    end
  end
end

