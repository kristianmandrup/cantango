class CanTangoTest < CanTango::Ability
  def initialize candidate, options = {}
    stamper("raw CanTango::Ability#initialize performance") { 
      super 
    }
  end
end

