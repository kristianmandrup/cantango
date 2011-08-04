class <%= role.to_s.camelize %>Permit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {})
    super
    return if !role_match? user
    <%= permit_logic.strip %>
    <%= license_logic %>
  end  
end
