CanTango.configure do |config|
  config.guest.user Proc.new { Guest.instance }

  config.cache.set :on
  config.permits.set :on
  config.permissions.set :on
end
# puts "guest_user_procedure:"
# puts CanTango::Configuration.methods.sort
# puts CanTango::Configuration.guest_user_procedure.inspect

