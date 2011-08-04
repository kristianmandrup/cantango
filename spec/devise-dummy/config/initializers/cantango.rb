CanTango.configure do |config|
  config.guest_user Proc.new { Guest.instance }
end

puts "guest_user_procedure:"
puts CanTango::Configuration.guest_user_procedure

