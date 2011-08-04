class <%= name.to_s.camelize %>License < License::Base
  def initialize name
    super
  end
  
  def enforce!
    <%= enforce_logic.strip %>
    <%= license_logic %>    
  end  
end
