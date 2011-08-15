class MusiciansLicense < CanTango::License
  def initialize name
    super
  end

  def static_rules
    can(:read, Song)
    can(:write, Tune)
    can(:manage, Concerto)
    cannot(:manage, Improvisation)
  end
end

