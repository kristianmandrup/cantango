module CanTangoTest
  def initialize candidate, options = {}
    raise "!!!!"
    super
  end
end

CanTango::Ability.class_eval %{
  include CanTangoTest
}
