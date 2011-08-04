class <%= permit_name.to_s.camelize %>Permit < Permit::Base
  def initialize(ability, options = {})
    super
  end

  def permit?(user, options = {})
    super
    <%= permit_logic %>
  end  
end
