class CanTangoTest < CanTango::Ability
  def initialize candidate, options = {}
    stamper { 
      super 
    }
  end
end

