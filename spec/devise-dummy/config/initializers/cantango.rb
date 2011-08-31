CanTango.configure do |config|
  config.guest.user Proc.new { Guest.instance }

  config.cache_engine.set :on
  config.permit_engine.set :on
  config.permission_engine.set :on
end

