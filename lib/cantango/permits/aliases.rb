[:role, :role_group,  :user_type, :account_type].each do |type|
  eval "CanTango::#{type.to_s.camelize}Permit = CanTango::Permits::#{type.to_s.camelize}Permit"
end