['', :role, :role_group,  :user, :account].each do |type|
  eval "CanTango::#{type.to_s.camelize}Permit = CanTango::Permits::#{type.to_s.camelize}Permit"
end
CanTango::License = CanTango::Permits::License
