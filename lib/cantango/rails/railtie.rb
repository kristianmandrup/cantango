module CanTango
  class Railtie < Rails::Railtie
    initializer "cantango" do |app|
      puts "initializing CanTango..."
    end
  end
end
